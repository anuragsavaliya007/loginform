

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:loginform/Dbhelper.dart';
import 'package:loginform/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class firstpage extends StatefulWidget {
  Map? map;
  String? method;
  firstpage(this.method, {this.map});

  

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {



  String dropdownvalue = 'Select City';
  var _selectedGender;

  Map m = {'Hindi':false,'Gujrati':false,'English':false,'Sanskrit':false};
  // List<bool> isChecked = [false,false,false,false];

  var items = [
    'Select City',
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
  ];

  DateTime selectedDate = DateTime.now();
  TextEditingController tfname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tphone = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  TextEditingController tcpassword = TextEditingController();
  TextEditingController tdate = TextEditingController();
  String? abc;
  String? bcd;
  String? cde;
  String? def;
  String? cpassword;
  String lerror = "";
  String gerror = "";
  String serror = "";
  String merror = "";
  final _formKey = GlobalKey<FormState>();
  Database? db;


  @override
  void initState() {
    super.initState();

    if(widget.method == "update")
      {



        tfname.text = widget.map!['firstname'];
        temail.text = widget.map!['email'];
        tphone.text = widget.map!['phone'];
        tpassword.text = widget.map!['cpassword'];
        tcpassword.text = widget.map!['cpassword'];
        _selectedGender = widget.map!['gender'];
         m = widget.map!['languge'];
        dropdownvalue = widget.map!['city'];
        tdate.text = widget.map!['date'];


      }

    Dbhelper().creatdatabase().then((value) {

      db = value;

    },);

  }

 Future<bool> goback(){

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return viewpage();
    },));

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: GestureDetector(
      onTap: () {
        setState(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });

      },

      child: Scaffold(
        body: SafeArea(child: Form(
          key: _formKey,
          child: ListView(children: [

            //login name
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: FittedBox(child: Text("Login Form",style: TextStyle(fontSize: 40),)),),
            ),
            //first name
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(


                controller: tfname,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  label: Text("First Name"),
                  errorText: abc,

                ),),
            ),
            //email
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(

                onTap: () {
                  if(tfname.text.isEmpty)
                  {

                    abc = "Can\'t be empty";
                  }
                  else if(tfname.text.length < 4)
                  {

                    abc = "Too short";
                  }
                  else
                  {
                    abc =  null;

                  }
                  setState(() {

                  });

                },

                controller: temail,
                textInputAction: TextInputAction.next,
                // textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  label: Text("email address"),
                  errorText: bcd,

                ),),
            ),
            //phon
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(
                onTap: () {

                  if(EmailValidator.validate(temail.text)){
                    bcd = null;
                  }
                  else{
                    bcd = "Please enter a valid email";
                  }
                  setState(() {

                  });
                },
                controller: tphone,
                textInputAction: TextInputAction.next,
                // textCapitalization: TextCapitalization.,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  label: Text("Phone Number"),
                  errorText: def,

                ),),
            ),
            //password
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(
                onTap: () {

                  if(tphone.text.isEmpty){
                    def = "Enter phone number";
                  }
                  else if(tphone.text.length < 10)
                  {
                    def = "Enter Valid number";
                  }
                  else
                  {
                    def = null;
                  }
                  setState(() {

                  });

                },
                controller: tpassword,
                textInputAction: TextInputAction.next,
                // textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.visiblePassword,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  label: Text("Password"),
                  errorText: cde,

                ),),
            ),
            //conform password
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(

                onTap: () {
                  if(tpassword.text.isEmpty){
                    cde = "Enter password";
                  }
                  else if(tpassword.text.length < 8){
                    cde = "to Short min 8 latter";
                  }
                  else
                  {
                    cde = null;
                  }
                  setState(() {

                  });


                },
                controller: tcpassword,
                textInputAction: TextInputAction.next,
                // textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.visiblePassword,
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  label: Text("Conform Password"),
                  errorText: cpassword,

                ),),
            ),
            //gender
            Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Please let us know your gender:'),
                    ListTile(
                      leading: Radio<String>(
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Male'),
                    ),
                    ListTile(
                      leading: Radio<String>(
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Female'),
                    ),
                    ListTile(
                      leading: Radio<String>(
                        value: 'Other',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value!;
                          });
                        },
                      ),
                      title: const Text('Other'),
                    ),


                  ],
                )),
            Text("$gerror"),
            //languge
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Languge :",style: TextStyle(fontSize: 20)),
            ),
            Container(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: m['Hindi'],
                      onChanged: (value) {
                        setState(() {
                          m['Hindi'] = value!;
                        });
                      },
                    ),
                    Text("Hindi"),
                    Checkbox(
                      value: m['Gujrati'],
                      onChanged: (value) {
                        setState(() {
                          m['Gujrati'] = value!;
                        });
                      },
                    ),
                    Text("Gujrati"),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value:  m['English'],
                      onChanged: (value) {
                        setState(() {
                          m['English'] = value!;
                        });
                      },
                    ),
                    Text("English"),
                    Checkbox(
                      value: m['Sanskrit'],
                      onChanged: (value) {
                        setState(() {
                          m['Sanskrit'] = value!;
                        });
                      },
                    ),
                    Text("Sanskrit"),
                  ],),
              ],),
            ),
            Text("$lerror"),
            //state
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(

                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            Text("$serror"),
            //date,month,year
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: tdate,
                decoration: InputDecoration(
                  suffixIcon: IconButton(onPressed: () {

                    _selectDate(context);

                  }, icon: Icon(Icons.calendar_today)),
                  border: OutlineInputBorder(),
                  label: Text("Select Date"),

                ),
              ),
            ),
            Text("$merror"),
            //submit
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () async{

                String firstname = tfname.text;
                String email = temail.text;
                String phone = tphone.text;
                String cpassword = tcpassword.text;
                String gender = _selectedGender.toString();
                Map languge = m;
                String city = dropdownvalue;
                String date = tdate.text;

                if(tpassword.text == tcpassword.text){

                  if(widget.method == "insert"){

                    String qry = "INSERT INTO Loginpage(firstname,email,phone,cpassword,gender,languge,city,date) VALUES('$firstname','$email','$phone','$cpassword','$gender','$languge','$city','$date')";
                    int id = await db!.rawInsert(qry);

                    print(id);


                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {

                      return viewpage();

                    },));


                  }else{

                    String q = " update Loginpage set firstname='$firstname',email='$email',phone='$phone',cpassword='$cpassword',gender='$gender',languge='$languge',city='$city',date='$date' where id=${widget.map!['id']}";
                    int id = await db!.rawUpdate(q);
                    if(id == 1){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return viewpage();
                      },));
                    }
                  }



                }
                else
                {
                  cpassword = "Not Match Password ! plese Try Again ";
                  setState(() {

                  });

                }

                setState(() {

                });
              }, child: Text("${widget.method}")),
            ),

          ],),
        )),
      ),
    ), onWillPop:goback);
  }

  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        tdate.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
  }


}
