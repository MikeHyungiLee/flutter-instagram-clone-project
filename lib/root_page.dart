import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loading_page.dart';
import 'login_page.dart';
import 'tab_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('root_page created');
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    // firebase에서 stream으로 login상태를 가져올 수 있다.
    return StreamBuilder(
      // FirebaseAuth를 통해서 스트림을 받게 된다.(로그인/로그아웃의 상태의 변화에 따라)
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // 연결 상태가 기다리는 중이라면 로딩 페이지를 반환
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingPage();
        }else{
          //연결이 되었고 데이터가 있다면
          if(snapshot.hasData){
            // 데이터를 가지고 탭 페이지로 간다.
            return TabPage(snapshot.data);
          }
          // 인증 데이터가 없다면 로그인 페이지로 간다.
          return LoginPage();
        }
      }
    );
  }
}
