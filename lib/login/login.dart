import 'package:estagio_app/components/button.dart';
import 'package:estagio_app/components/input.dart';
import 'package:estagio_app/entity/user_entity.dart';
import 'package:estagio_app/login/register.dart';
import 'package:estagio_app/services/user_service.dart';
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
      opacity: 0.03,
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
    return Image.asset(
      'assets/feitep.png',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }

  _inputs(context) {
    return Column(
      children: <Widget>[
        Container(
          width: 270,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
          fontSize: 15,
          color: Color(0xFFC0C0C0),
        ),
      ),
    );
  }

  _enterButton(context) {
    return Container(
      width: 270,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Button(_enterButtonContent(), _onClickLogin),
    );
  }

  String _emailValidator(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
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
    final response = await service.login(email, password);
    User appUser = Provider.of<User>(context, listen: false);
    appUser.updateUser(User.fromJson(response));
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
