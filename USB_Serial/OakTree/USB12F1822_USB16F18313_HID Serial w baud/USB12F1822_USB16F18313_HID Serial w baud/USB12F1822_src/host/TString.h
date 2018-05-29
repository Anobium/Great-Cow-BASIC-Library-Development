/*
 *  ソフト名：    TString.h
 *  バージョン：  5.0 (2009/3/8日版)
 *  開発者：      JEX
 *  開発者ＨＰ：  http://ii2.matrix.jp/
 *  メール：      ii2.vertex@gmail.com（お気軽にどうぞ）
 *  著作権：      商用、非商用問わず作者に連絡無く自由に使えます。
 *                改ざんや二次配布もＯＫです。是非いろいろ改造して見てください。
 *                利用を報告してくれたら作者のモチベーションが上がるかもしれません。
 *
 *  TStringはなかなか便利な文字列ライブラリです。
 *  特に面倒なマルチバイトやユニコードの相互変換などを自動でやってくれるため、
 *  わずらわしい思いをしなくていいのが強みです。
 *  他にもC++のstringやwstring、WINAPIのLPCTSTR、普通のC言語のcharやwchar_tなどとも連動して使えます。
 *  しかも使い方も非常に簡単で直感的です。ここではサンプルをいくつか示します。
 *  一応マルチバイトとユニコードについてはこちらにも詳しい解説がありますので参考にどうぞ。
 *
 *  LPCTSTRだの_T("")だのユニコードだのの世界一詳しい解説：
 *  http://ii2.matrix.jp/Junk/_T/index.html
 *
 * --------------------------------------------------------------------------------
 *  利用法：#include "TString.h"するだけで使えます
 *
 *  使用例１：
 *      TString tStr = "あああ";
 *      tStr += "いいい";
 *      printf( tStr.GetStringA() );
 *      出力：あああいいい
 *
 *  使用例２：
 *      TString tStr = L"ユニコード文字列";
 *      tStr += "マルチバイト文字列";
 *      MessageBox( NULL, tStr, NULL, MB_OK );
 *      出力：ユニコード文字列マルチバイト文字列
 *	
 *  使用例３：
 *      TString tStr;
 *      tStr = _T("両対応の文字列");
 *      MessageBox  ( NULL, tStr, NULL, MB_OK );                    //設定に応じた文字列を取り出す例
 *      MessageBoxA ( NULL, tStr.GetStringA(), NULL, MB_OK );       //マルチバイト文字列を取り出す例
 *      MessageBoxW ( NULL, tStr.GetStringW(), NULL, MB_OK );       //ユニコード文字列を取り出す例
 *	
 *  使用例４：
 *      // 一時変数を使わずに戻り値で文字列を取得する例
 *      MessageBox  ( NULL, TString( "マルチバイト文字列" ), NULL, MB_OK );			
 *      MessageBoxA ( NULL, TString( L"ユニコード文字列" ).GetStringA(), NULL, MB_OK );
 *      MessageBoxW ( NULL, TSTring( "マルチバイト文字列" ).GetStringW(), NULL, MB_OK );
 *
 * -----------------------------------------------------------------------------------------
 *  <関数リファレンス>
 *	
 *  GetString       ... TCHAR *型 (LPCTSTR) で文字列全体を取得
 *  GetStringA      ...  char *型 ( LPCSTR) で文字列全体を取得
 *  GetStringW      ... WCHAR *型 (LPCWSTR) で文字列全体を取得
 *  GetString       ... 引数で範囲を指定した場合。TCHAR単位で指定範囲の文字列を取得
 *  GetStringA      ... 引数で範囲を指定した場合。 char単位で指定範囲の文字列を取得
 *  GetStringW      ... 引数で範囲を指定した場合。WCHAR単位で指定範囲の文字列を取得
 *  At              ... TCHAR型で配列の要素を取得（[]で取得するのと同じ）
 *  AtA             ...  char型で配列の要素を取得
 *  AtW             ... WCHAR型で配列の要素を取得
 *  GetSize         ... TCHAR単位で文字数を取得
 *  GetSizeA        ...  char単位で文字数を取得
 *  GetSizeW        ... WCHAR単位で文字数を取得
 *  GetLength       ... GetSizeと同一
 *  GetLengthA      ... GetSizeAと同一
 *  GetLengthW      ... GetSizeWと同一
 *  Find            ... 指定のキーワードが含まれていたらその最初の位置をTCHAR単位で返す。(いないなら-1)
 *  FindA           ... 指定のキーワードが含まれていたらその最初の位置を char単位で返す。(いないなら-1)
 *  FindW           ... 指定のキーワードが含まれていたらその最初の位置をWCHAR単位で返す。(いないなら-1)
 *  Replace         ... 指定のキーワードを指定の文字列で全て置き換えます
 *
 ********************************************************************************************/

#ifndef DEF_TSTRING
#define DEF_TSTRING

#include <cstring>
#include <iostream>
#include <windows.h>
#include <tchar.h>

using namespace std;

#pragma warning ( disable: 4996 )

// atlstr.h内にあるATLのCString型が無料版のVisualStudioでは
// サポートされていないので同じ働きをするクラスを作った。
// CString型は非常に優秀であるので所詮車輪の再発明に過ぎない。
class TString {
	// 文字列格納用変数。stringがマルチバイト文字列、wstringがユニコード文字列用
	string		mbStr;
	wstring		wStr;

	// WideToMBCSなどでのメモリ無限増大を防ぐための文字列リターナー
	string		mbRetStr;			
	wstring		wRetStr;

	// 設定に応じて文字列を同期
	void StringSync()
	{
		#ifdef _UNICODE
			mbStr = WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			wStr = MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}
public:
	// デフォルトのコンストラクタ
	TString()
	{
		
	}

	// char型代入のコンストラクタ
	TString( int num )
	{
		#ifdef _UNICODE
			WCHAR buf[ 256 ];
			_itow( num, buf, 10 );
			wStr = buf;
		#else
			char buf[ 256 ];
			_itoa( num, buf, 10 );
			mbStr = buf;
		#endif
	}

	// float型代入のコンストラクタ
	TString( float fNum, int UnderDigit )
	{
		#ifdef _UNICODE
			WCHAR buf[ 256 ];
			switch ( UnderDigit )
			{
			case 0:		swprintf( buf, L"%f", fNum );		break;
			case 1:		swprintf( buf, L"%.1f", fNum );		break;
			case 2:		swprintf( buf, L"%.2f", fNum );		break;
			case 3:		swprintf( buf, L"%.3f", fNum );		break;
			case 4:		swprintf( buf, L"%.4f", fNum );		break;
			case 5:		swprintf( buf, L"%.5f", fNum );		break;
			}
			wStr = buf;
		#else
			char buf[ 256 ];
			switch ( UnderDigit )
			{
			case 0:		sprintf( buf, "%f", fNum );			break;
			case 1:		sprintf( buf, "%.1f", fNum );		break;
			case 2:		sprintf( buf, "%.2f", fNum );		break;
			case 3:		sprintf( buf, "%.3f", fNum );		break;
			case 4:		sprintf( buf, "%.4f", fNum );		break;
			case 5:		sprintf( buf, "%.5f", fNum );		break;
			}
			mbStr = buf;
		#endif
	}

	// char型代入のコンストラクタ
	TString( char ch )
	{
		#ifdef _UNICODE
			wStr = (WCHAR)ch;
		#else
			mbStr = ch;
		#endif
	}

	// WCHAR型代入のコンストラクタ
	TString( WCHAR wch )
	{
		#ifdef _UNICODE
			wStr = wch;
		#else
			wstring ws;
			ws += wch;
			mbStr = WideToMBCS( (WCHAR *)ws.c_str() );
		#endif
	}

	// char *型代入のコンストラクタ
	TString( const char * str )
	{
		#ifdef _UNICODE
			wStr = MBCSToWide( (char *)str );
		#else
			mbStr = str;
		#endif
	}

	// WCHAR *型代入のコンストラクタ
	TString( const WCHAR * str )
	{
		#ifdef _UNICODE
			wStr = str;
		#else
			mbStr = WideToMBCS( (WCHAR *)str );
		#endif
	}

	// string型代入のコンストラクタ
	TString( string str )
	{
		#ifdef _UNICODE
			wStr = MBCSToWide( (char *)str.c_str() );
		#else
			mbStr = str;
		#endif
	}

	// wstring型代入のコンストラクタ
	TString( wstring str )
	{
		#ifdef _UNICODE
			wStr = str;
		#else
			mbStr = WideToMBCS( (WCHAR *)str.c_str() );
		#endif
	}

	// 戻り値のオーバーロード
	operator LPCTSTR()
	{
		return (this)->GetString();
	}

	// 代入されている文字列を取得
	LPCTSTR GetString()
	{
		#ifdef _UNICODE
			return wStr.c_str();
		#else
			return mbStr.c_str();
		#endif
	}

	// 代入文字列のマルチバイト文字列版を取得
	char * GetStringA()
	{
		#ifdef _UNICODE
			return WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			return (char *)mbStr.c_str();
		#endif
	}

	// 代入文字列のユニコード文字列版を取得
	WCHAR * GetStringW()
	{
		#ifdef _UNICODE
			return (WCHAR *)wStr.c_str();
		#else
			return MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}

	// 文字列の指定要素を返す
	TCHAR At( int index )
	{
		StringSync();
		#ifdef _UNICODE
			return wStr[ index ];
		#else
			return mbStr[ index ];
		#endif	
	}

	// 文字列の指定要素を返す（MBCS）
	char AtA( int index )
	{
		StringSync();
		return mbStr[ index ];
	}

	// 文字列の指定要素を返す（UNICODE）
	WCHAR AtW( int index )
	{
		StringSync();
		return wStr[ index ];
	}

	// 代入されている文字列の長さ（GetSizeの単なる別名）
	int GetLength()		{ return GetSize();  }
	int GetLengthA()	{ return GetSizeA(); }
	int GetLengthW()	{ return GetSizeW(); }

	// 代入されている文字列の長さ
	int GetSize()
	{
		#ifdef _UNICODE
			return (int)wStr.size();
		#else
			return (int)mbStr.size();
		#endif
	}

	// 代入されている文字列の長さ（MBCS単位で取得）
	int GetSizeA()
	{
		StringSync();
		return (int)mbStr.size();
	}

	// 代入されている文字列の長さ（UNICODE単位で取得）
	int GetSizeW()
	{
		StringSync();
		return (int)wStr.size();
	}

	// 代入演算子のオーバーロード
	TString & operator=( char rhs )
	{
		#ifdef _UNICODE
			wStr = (WCHAR)rhs;
			return *this;
		#else
			mbStr = rhs;
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( WCHAR rhs )
	{
		#ifdef _UNICODE
			wStr = rhs;
			return *this;
		#else
			mbStr = (char)( rhs );
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( TString rhs )
	{
		#ifdef _UNICODE
			wStr = rhs.GetString();
			return *this;
		#else
			mbStr = rhs.GetString();
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( const char * rhs )
	{
		#ifdef _UNICODE
			wStr = MBCSToWide( (char *)rhs );
			return *this;
		#else
			mbStr = rhs;
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( const WCHAR * rhs )
	{
		#ifdef _UNICODE
			wStr = rhs;
			return *this;
		#else
			mbStr = WideToMBCS( (WCHAR *)rhs );
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( string rhs )
	{
		#ifdef _UNICODE
		wStr = MBCSToWide( (char *)rhs.c_str() );
			return *this;
		#else
			mbStr = rhs;
			return *this;
		#endif
	}

	// 代入演算子のオーバーロード
	TString & operator=( wstring rhs )
	{
		#ifdef _UNICODE
			wStr = rhs;
			return *this;
		#else
			mbStr = WideToMBCS( (WCHAR *)rhs.c_str() );
			return *this;
		#endif
	}

	// +演算子のオーバーロード
	TString operator+( TString rhs )
	{
		#ifdef _UNICODE
			wstring finalStr = wStr.c_str();
			finalStr += rhs.GetString();
			return finalStr.c_str();
		#else
			string finalStr = mbStr.c_str();
			finalStr += rhs.GetString();
			return finalStr.c_str();
		#endif
	}

	// +自動変換演算子のオーバーロード TString + char *
	TString operator+( char * rhs )
	{
		#ifdef _UNICODE
			wstring finalStr = wStr.c_str();
			finalStr += MBCSToWide( rhs );
			return finalStr.c_str();
		#else
			string finalStr = mbStr.c_str();
			finalStr += rhs;
			return finalStr.c_str();
		#endif
	}

	// +自動変換演算子のオーバーロード TString + WCHAR *
	TString operator+( WCHAR * rhs )
	{
		#ifdef _UNICODE
			wstring finalStr = wStr.c_str();
			finalStr += rhs;
			return finalStr.c_str();
		#else
			string finalStr = mbStr.c_str();
			finalStr += WideToMBCS( rhs );
			return finalStr.c_str();
		#endif
	}

	// +自動変換演算子のオーバーロード TString + string
	TString operator+( string rhs )
	{
		#ifdef _UNICODE
			wstring finalStr = wStr.c_str();
			finalStr += MBCSToWide( (char *)rhs.c_str() );
			return finalStr.c_str();
		#else
			string finalStr = mbStr.c_str();
			finalStr += rhs;
			return finalStr.c_str();
		#endif
	}

	// +自動変換演算子のオーバーロード TString + wstring
	TString operator+( wstring rhs )
	{
		#ifdef _UNICODE
			wstring finalStr = wStr.c_str();
			finalStr += rhs;
			return finalStr.c_str();
		#else
			string finalStr = mbStr.c_str();
			finalStr += WideToMBCS( (WCHAR *)rhs.c_str() );
			return finalStr.c_str();
		#endif
	}

	// +=演算子のオーバーロード TString = TString
	TString operator+=( TString rhs )
	{
		#ifdef _UNICODE
			wStr += rhs.GetString();
			return wStr.c_str();
		#else
			mbStr += rhs.GetString();
			return mbStr.c_str();
		#endif
	}

	// +=自動変換演算子のオーバーロード TString += char*
	TString operator+=( const char * rhs )
	{
		#ifdef _UNICODE
			wStr += MBCSToWide( (char *)rhs );
			return wStr.c_str();
		#else
			mbStr += rhs;
			return mbStr.c_str();
		#endif
	}

	// +=自動変換演算子のオーバーロード TString += WCHAR*
	TString operator+=( const WCHAR * rhs )
	{
		#ifdef _UNICODE
			wStr += rhs;
			return wStr.c_str();
		#else
			mbStr += WideToMBCS( (WCHAR *)rhs );
			return mbStr.c_str();
		#endif
	}

	// +=自動変換演算子のオーバーロード TString += string
	TString operator+=( string rhs )
	{
		#ifdef _UNICODE
			wStr += MBCSToWide( (char *)rhs.c_str() );
			return wStr.c_str();
		#else
			mbStr += rhs;
			return mbStr.c_str();
		#endif
	}

	// +=自動変換演算子のオーバーロード TString += wstring
	TString operator+=( const wstring rhs )
	{
		#ifdef _UNICODE
			wStr += rhs;
			return wStr.c_str();
		#else
			mbStr += WideToMBCS( (WCHAR *)rhs.c_str() );
			return mbStr.c_str();
		#endif
	}

	// []演算子のオーバーロード
	TCHAR & operator[]( int idx )
	{
		#ifdef _UNICODE
			return wStr		[ idx ];
		#else
			return mbStr	[ idx ];
		#endif
	}

	// ==演算子のオーバーロード
	int operator==( const char * rhs )
	{
		#ifdef _UNICODE
			if ( wcscmp( wStr.c_str(), MBCSToWide( (char *)rhs ) ) )
				return false;
			else
				return true;
		#else
			if ( strcmp( mbStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#endif
	}

	// ==演算子のオーバーロード
	int operator==( const WCHAR * rhs )
	{
		#ifdef _UNICODE
			if ( wcscmp( wStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#else
			if ( strcmp( mbStr.c_str(), WideToMBCS( (WCHAR *)rhs ) ) )
				return false;
			else
				return true;
		#endif
	}

	// ==演算子のオーバーロード
	int operator==( TString rhs )
	{
		#ifdef _UNICODE
			if ( wcscmp( wStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#else
			if ( strcmp( mbStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#endif
	}

	// ==演算子のオーバーロード
	int operator==( string rhs )
	{
		#ifdef _UNICODE
			if ( wcscmp( wStr.c_str(), MBCSToWide( (char *)rhs.c_str() ) ) )
				return false;
			else
				return true;
		#else
			if ( strcmp( mbStr.c_str(), rhs.c_str() ) )
				return false;
			else
				return true;
		#endif
	}

	// ==演算子のオーバーロード
	int operator==( wstring rhs )
	{
		#ifdef _UNICODE
			if ( wcscmp( wStr.c_str(), rhs.c_str() ) )
				return false;
			else
				return true;
		#else
			if ( strcmp( mbStr.c_str(), WideToMBCS( (WCHAR *)rhs.c_str() ) ) )
				return false;
			else
				return true;
		#endif
	}

	// !=演算子のオーバーロード
	int operator!=( const char * rhs )
	{
		#ifdef _UNICODE
			if ( !wcscmp( wStr.c_str(), MBCSToWide( (char *)rhs ) ) )
				return false;
			else
				return true;
		#else
			if ( !strcmp( mbStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#endif
	}

	// !=演算子のオーバーロード
	int operator!=( const WCHAR * rhs )
	{
		#ifdef _UNICODE
			if ( !wcscmp( wStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#else
			if ( !strcmp( mbStr.c_str(), WideToMBCS( (WCHAR *)rhs ) ) )
				return false;
			else
				return true;
		#endif
	}

	// !=演算子のオーバーロード
	int operator!=( TString rhs )
	{
		#ifdef _UNICODE
			if ( !wcscmp( wStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#else
			if ( !strcmp( mbStr.c_str(), rhs ) )
				return false;
			else
				return true;
		#endif
	}

	// !=演算子のオーバーロード
	int operator!=( string rhs )
	{
		#ifdef _UNICODE
			if ( !wcscmp( wStr.c_str(), MBCSToWide( (char *)rhs.c_str() ) ) )
				return false;
			else
				return true;
		#else
			if ( !strcmp( mbStr.c_str(), rhs.c_str() ) )
				return false;
			else
				return true;
		#endif
	}

	// !=演算子のオーバーロード
	int operator!=( wstring rhs )
	{
		#ifdef _UNICODE
			if ( !wcscmp( wStr.c_str(), rhs.c_str() ) )
				return false;
			else
				return true;
		#else
			if ( !strcmp( mbStr.c_str(), WideToMBCS( (WCHAR *)rhs.c_str() ) ) )
				return false;
			else
				return true;
		#endif
	}

	//
	//	指定のキーワードが含まれていたらその最初の位置を返す。含まれないなら-1を返す
	//
	int Find( TString KeyWord )
	{
		int ret = 0;
		
		#ifdef _UNICODE
			ret = (int)wStr.find( KeyWord.GetStringW() );
			if ( ret == std::wstring::npos )
				return -1;
		#else
			ret = (int)mbStr.find( KeyWord.GetStringA() );
			if ( ret == std::string::npos )
				return -1;
		#endif

		return ret;
	}

	//
	//	指定のキーワードが含まれていたらその最初の位置を返す。含まれないなら-1を返す（MBCS）
	// 
	int FindA( TString KeyWord )
	{
		StringSync();
		int ret = (int)mbStr.find( KeyWord.GetStringA() );
		
		if ( ret == std::string::npos )
			return -1;

		return ret;
	}

	//
	//	指定のキーワードが含まれていたらその最初の位置を返す。含まれないなら-1を返す（UNICODE）
	//
	int FindW( TString KeyWord )
	{
		StringSync();
		int ret = (int)wStr.find( KeyWord.GetStringW() );
		
		if ( ret == std::wstring::npos )
			return -1;

		return ret;
	}

	//
	//	指定の範囲を文字列で取得（MBCSかUNICODEかの設定により位置が変化するので注意）
	//
	LPCTSTR GetString( int start, int end )
	{
		TString finalStr;
		for ( int i( start ); i < end; i++ )
		{
			#ifdef _UNICODE
				finalStr += wStr[ i ];		
			#else
				finalStr += mbStr[ i ];	
			#endif
		}
		return finalStr;
	}

	
	//
	//	指定の範囲を文字列で取得（MBCS位置で取得）
	//
	char * GetStringA( int start, int end )
	{
		string finalStr;
		StringSync();

		for ( int i( start ); i < end; i++ )
			finalStr += mbStr[ i ];	

		mbRetStr = finalStr;
		return (char *)mbRetStr.c_str();
	}

	//
	//	指定の範囲を文字列で取得（UNICODE位置で取得）
	//
	WCHAR * GetStringW( int start, int end )
	{
		wstring finalStr;
		StringSync();
		
		for ( int i( start ); i < end; i++ )
			finalStr += wStr[ i ];
		
		wRetStr = finalStr;
		return (WCHAR *)wRetStr.c_str();
	}

	void Replace( char * FromString, char * ToString )
	{
		
		#ifdef _UNICODE
			wstring::size_type pos = 0;

			wstring f = TString( FromString ).GetStringW();
			wstring t = TString( ToString ).GetStringW();

			while ( pos = wStr.find( f, pos ), pos != wstring::npos )
			{
				wStr.replace( pos, f.length(), t );
				pos += t.length();
			}
			mbStr = WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			string::size_type pos = 0;

			string f = FromString;
			string t = ToString;

			while ( pos = mbStr.find( f, pos ), pos != string::npos )
			{
				mbStr.replace( pos, f.length(), t );
				pos += t.length();
			}
			wStr = MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}

	void Replace( WCHAR * FromString, WCHAR * ToString )
	{
		
		#ifdef _UNICODE
			wstring::size_type pos = 0;

			wstring f = FromString;
			wstring t = ToString;

			while ( pos = wStr.find( f, pos ), pos != wstring::npos )
			{
				wStr.replace( pos, f.length(), t );
				pos += t.length();
			}
			mbStr = WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			string::size_type pos = 0;

			string f = TString( FromString ).GetStringA();
			string t = TString( ToString ).GetStringA();

			while ( pos = mbStr.find( f, pos ), pos != string::npos )
			{
				mbStr.replace( pos, f.length(), t );
				pos += t.length();
			}
			wStr = MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}


	//
	//	ユニコード文字列からマルチバイト文字列へ変換
	//
	char * WideToMBCS( WCHAR * wString )
	{
		int		len = WideCharToMultiByte( CP_ACP, 0, wString, -1, NULL, 0, NULL, NULL);
		char *	buf = new char[ len + 1 ];
		if ( buf == NULL )
			return NULL;
		
	    WideCharToMultiByte( CP_ACP, 0, wString, -1, buf, len + 1, NULL, NULL) ;
		*( buf + len ) = '\0';
		mbRetStr = buf;
		delete [] buf;
		return (char *)mbRetStr.c_str();
	}

	//
	//	マルチバイト文字列からユニコード文字列へ変換
	//
	WCHAR * MBCSToWide( char * mbString )
	{
		int	len = MultiByteToWideChar( CP_ACP, 0, mbString, -1, NULL, 0 );
		WCHAR *	buf = new WCHAR[ len + 1 ];
		if ( buf == NULL )
			return NULL;
		
	    MultiByteToWideChar( CP_ACP, 0, mbString, -1, buf, len + 1 ) ;
		*( buf + len ) = '\0';
		wRetStr = buf;
		delete [] buf;
		return (WCHAR *)wRetStr.c_str();
	}
} ;

#endif