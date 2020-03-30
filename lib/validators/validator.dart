class Validators{
  bool validate(String email,String password){
    if(email.isNotEmpty && password.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
}