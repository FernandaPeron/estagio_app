import 'package:email_validator/email_validator.dart';
import 'package:estagio_app/api/api_response.dart';
import 'package:estagio_app/components/button.dart';
import 'package:estagio_app/components/input.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/pages/home/home.dart';
import 'package:estagio_app/pages/login/register.dart';
import 'package:estagio_app/services/user_service.dart';
import 'package:estagio_app/utils/alert.dart';
import 'package:estagio_app/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showProgress = false;
  final service = new UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _buildBody(context),
    );
  }

  _buildBody(context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          _backgroundImage(size),
          _form(size, context),
        ],
      ),
    );
  }

  _backgroundImage(Size size) {
    return Opacity(
      opacity: 0.2,
      child: Image.asset(
        'assets/feitep.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }

  _form(Size size, context) {
    return Form(
      key: _formKey,
      child: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _title(size),
            _inputs(context),
            _enterButton(context),
            _registerButton(context),
          ],
        ),
      ),
    );
  }

  _title(Size size) {
    return Container(
      child: Image.asset('assets/title.png'),
      margin: EdgeInsets.fromLTRB(0, 60, 0, 30),
      height: 120,
      width: 160,
    );
  }

  _inputs(context) {
    return Column(
      children: <Widget>[
        Container(
          width: 270,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: InputField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: _emailValidator,
            hint: "E-mail",
          ),
        ),
        Container(
          width: 270,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: InputField(
            controller: _passwordController,
            validator: _passwordValidator,
            hint: "Senha",
            obscureText: true,
          ),
        ),
      ],
    );
  }

  _registerButton(context) {
    return GestureDetector(
      onTap: () {
        push(context, Register());
      },
      child: new Text(
        "Registrar",
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  _enterButton(context) {
    return Container(
      width: 200,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Button(_enterButtonContent(), _onClickLogin, primary: true,),
    );
  }

  String _emailValidator(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail.";
    }
    if (!EmailValidator.validate(text)) {
      return "E-mail inválido.";
    }
    return null;
  }

  String _passwordValidator(String text) {
    if (text.isEmpty) {
      return "Digite sua senha";
    }
    return null;
  }

  _onClickLogin() async {
    bool isValidForm = _formKey.currentState.validate();

    if (!isValidForm) return;

    String email = _emailController.text;
    String password = _passwordController.text;

    setState(() {
      _showProgress = true;
    });
    ApiResponse response = await service.login(email, password);
    if (response != null && response.isOk) {
      User appUser = Provider.of<User>(context, listen: false);
      appUser.updateUser(response.result);
      push(context, Home(), replace: true);
    } else {
      alert(context, response.msg);
    }
    setState(() {
      _showProgress = false;
    });
  }

  _enterButtonContent() {
    return _showProgress ? _buttonLoading() : _buttonText();
  }

  _buttonText() {
    return Text(
      "Entrar",
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  _buttonLoading() {
    return Center(
      child: Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
