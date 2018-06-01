/*
 *  �\�t�g���F    TString.h
 *  �o�[�W�����F  5.0 (2009/3/8����)
 *  �J���ҁF      JEX
 *  �J���҂g�o�F  http://ii2.matrix.jp/
 *  ���[���F      ii2.vertex@gmail.com�i���C�y�ɂǂ����j
 *  ���쌠�F      ���p�A�񏤗p��킸��҂ɘA���������R�Ɏg���܂��B
 *                �������񎟔z�z���n�j�ł��B���񂢂낢��������Č��Ă��������B
 *                ���p��񍐂��Ă��ꂽ���҂̃��`�x�[�V�������オ�邩������܂���B
 *
 *  TString�͂Ȃ��Ȃ��֗��ȕ����񃉃C�u�����ł��B
 *  ���ɖʓ|�ȃ}���`�o�C�g�⃆�j�R�[�h�̑��ݕϊ��Ȃǂ������ł���Ă���邽�߁A
 *  �킸��킵���v�������Ȃ��Ă����̂����݂ł��B
 *  ���ɂ�C++��string��wstring�AWINAPI��LPCTSTR�A���ʂ�C�����char��wchar_t�ȂǂƂ��A�����Ďg���܂��B
 *  �������g���������ɊȒP�Œ����I�ł��B�����ł̓T���v���������������܂��B
 *  �ꉞ�}���`�o�C�g�ƃ��j�R�[�h�ɂ��Ă͂�����ɂ��ڂ������������܂��̂ŎQ�l�ɂǂ����B
 *
 *  LPCTSTR����_T("")���̃��j�R�[�h���̂̐��E��ڂ�������F
 *  http://ii2.matrix.jp/Junk/_T/index.html
 *
 * --------------------------------------------------------------------------------
 *  ���p�@�F#include "TString.h"���邾���Ŏg���܂�
 *
 *  �g�p��P�F
 *      TString tStr = "������";
 *      tStr += "������";
 *      printf( tStr.GetStringA() );
 *      �o�́F������������
 *
 *  �g�p��Q�F
 *      TString tStr = L"���j�R�[�h������";
 *      tStr += "�}���`�o�C�g������";
 *      MessageBox( NULL, tStr, NULL, MB_OK );
 *      �o�́F���j�R�[�h������}���`�o�C�g������
 *	
 *  �g�p��R�F
 *      TString tStr;
 *      tStr = _T("���Ή��̕�����");
 *      MessageBox  ( NULL, tStr, NULL, MB_OK );                    //�ݒ�ɉ���������������o����
 *      MessageBoxA ( NULL, tStr.GetStringA(), NULL, MB_OK );       //�}���`�o�C�g����������o����
 *      MessageBoxW ( NULL, tStr.GetStringW(), NULL, MB_OK );       //���j�R�[�h����������o����
 *	
 *  �g�p��S�F
 *      // �ꎞ�ϐ����g�킸�ɖ߂�l�ŕ�������擾�����
 *      MessageBox  ( NULL, TString( "�}���`�o�C�g������" ), NULL, MB_OK );			
 *      MessageBoxA ( NULL, TString( L"���j�R�[�h������" ).GetStringA(), NULL, MB_OK );
 *      MessageBoxW ( NULL, TSTring( "�}���`�o�C�g������" ).GetStringW(), NULL, MB_OK );
 *
 * -----------------------------------------------------------------------------------------
 *  <�֐����t�@�����X>
 *	
 *  GetString       ... TCHAR *�^ (LPCTSTR) �ŕ�����S�̂��擾
 *  GetStringA      ...  char *�^ ( LPCSTR) �ŕ�����S�̂��擾
 *  GetStringW      ... WCHAR *�^ (LPCWSTR) �ŕ�����S�̂��擾
 *  GetString       ... �����Ŕ͈͂��w�肵���ꍇ�BTCHAR�P�ʂŎw��͈͂̕�������擾
 *  GetStringA      ... �����Ŕ͈͂��w�肵���ꍇ�B char�P�ʂŎw��͈͂̕�������擾
 *  GetStringW      ... �����Ŕ͈͂��w�肵���ꍇ�BWCHAR�P�ʂŎw��͈͂̕�������擾
 *  At              ... TCHAR�^�Ŕz��̗v�f���擾�i[]�Ŏ擾����̂Ɠ����j
 *  AtA             ...  char�^�Ŕz��̗v�f���擾
 *  AtW             ... WCHAR�^�Ŕz��̗v�f���擾
 *  GetSize         ... TCHAR�P�ʂŕ��������擾
 *  GetSizeA        ...  char�P�ʂŕ��������擾
 *  GetSizeW        ... WCHAR�P�ʂŕ��������擾
 *  GetLength       ... GetSize�Ɠ���
 *  GetLengthA      ... GetSizeA�Ɠ���
 *  GetLengthW      ... GetSizeW�Ɠ���
 *  Find            ... �w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu��TCHAR�P�ʂŕԂ��B(���Ȃ��Ȃ�-1)
 *  FindA           ... �w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu�� char�P�ʂŕԂ��B(���Ȃ��Ȃ�-1)
 *  FindW           ... �w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu��WCHAR�P�ʂŕԂ��B(���Ȃ��Ȃ�-1)
 *  Replace         ... �w��̃L�[���[�h���w��̕�����őS�Ēu�������܂�
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

// atlstr.h���ɂ���ATL��CString�^�������ł�VisualStudio�ł�
// �T�|�[�g����Ă��Ȃ��̂œ�������������N���X��������B
// CString�^�͔��ɗD�G�ł���̂ŏ��F�ԗւ̍Ĕ����ɉ߂��Ȃ��B
class TString {
	// ������i�[�p�ϐ��Bstring���}���`�o�C�g������Awstring�����j�R�[�h������p
	string		mbStr;
	wstring		wStr;

	// WideToMBCS�Ȃǂł̃��������������h�����߂̕����񃊃^�[�i�[
	string		mbRetStr;			
	wstring		wRetStr;

	// �ݒ�ɉ����ĕ�����𓯊�
	void StringSync()
	{
		#ifdef _UNICODE
			mbStr = WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			wStr = MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}
public:
	// �f�t�H���g�̃R���X�g���N�^
	TString()
	{
		
	}

	// char�^����̃R���X�g���N�^
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

	// float�^����̃R���X�g���N�^
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

	// char�^����̃R���X�g���N�^
	TString( char ch )
	{
		#ifdef _UNICODE
			wStr = (WCHAR)ch;
		#else
			mbStr = ch;
		#endif
	}

	// WCHAR�^����̃R���X�g���N�^
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

	// char *�^����̃R���X�g���N�^
	TString( const char * str )
	{
		#ifdef _UNICODE
			wStr = MBCSToWide( (char *)str );
		#else
			mbStr = str;
		#endif
	}

	// WCHAR *�^����̃R���X�g���N�^
	TString( const WCHAR * str )
	{
		#ifdef _UNICODE
			wStr = str;
		#else
			mbStr = WideToMBCS( (WCHAR *)str );
		#endif
	}

	// string�^����̃R���X�g���N�^
	TString( string str )
	{
		#ifdef _UNICODE
			wStr = MBCSToWide( (char *)str.c_str() );
		#else
			mbStr = str;
		#endif
	}

	// wstring�^����̃R���X�g���N�^
	TString( wstring str )
	{
		#ifdef _UNICODE
			wStr = str;
		#else
			mbStr = WideToMBCS( (WCHAR *)str.c_str() );
		#endif
	}

	// �߂�l�̃I�[�o�[���[�h
	operator LPCTSTR()
	{
		return (this)->GetString();
	}

	// �������Ă��镶������擾
	LPCTSTR GetString()
	{
		#ifdef _UNICODE
			return wStr.c_str();
		#else
			return mbStr.c_str();
		#endif
	}

	// ���������̃}���`�o�C�g������ł��擾
	char * GetStringA()
	{
		#ifdef _UNICODE
			return WideToMBCS( (WCHAR *)wStr.c_str() );
		#else
			return (char *)mbStr.c_str();
		#endif
	}

	// ���������̃��j�R�[�h������ł��擾
	WCHAR * GetStringW()
	{
		#ifdef _UNICODE
			return (WCHAR *)wStr.c_str();
		#else
			return MBCSToWide( (char *)mbStr.c_str() );
		#endif
	}

	// ������̎w��v�f��Ԃ�
	TCHAR At( int index )
	{
		StringSync();
		#ifdef _UNICODE
			return wStr[ index ];
		#else
			return mbStr[ index ];
		#endif	
	}

	// ������̎w��v�f��Ԃ��iMBCS�j
	char AtA( int index )
	{
		StringSync();
		return mbStr[ index ];
	}

	// ������̎w��v�f��Ԃ��iUNICODE�j
	WCHAR AtW( int index )
	{
		StringSync();
		return wStr[ index ];
	}

	// �������Ă��镶����̒����iGetSize�̒P�Ȃ�ʖ��j
	int GetLength()		{ return GetSize();  }
	int GetLengthA()	{ return GetSizeA(); }
	int GetLengthW()	{ return GetSizeW(); }

	// �������Ă��镶����̒���
	int GetSize()
	{
		#ifdef _UNICODE
			return (int)wStr.size();
		#else
			return (int)mbStr.size();
		#endif
	}

	// �������Ă��镶����̒����iMBCS�P�ʂŎ擾�j
	int GetSizeA()
	{
		StringSync();
		return (int)mbStr.size();
	}

	// �������Ă��镶����̒����iUNICODE�P�ʂŎ擾�j
	int GetSizeW()
	{
		StringSync();
		return (int)wStr.size();
	}

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// ������Z�q�̃I�[�o�[���[�h
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

	// +���Z�q�̃I�[�o�[���[�h
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

	// +�����ϊ����Z�q�̃I�[�o�[���[�h TString + char *
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

	// +�����ϊ����Z�q�̃I�[�o�[���[�h TString + WCHAR *
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

	// +�����ϊ����Z�q�̃I�[�o�[���[�h TString + string
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

	// +�����ϊ����Z�q�̃I�[�o�[���[�h TString + wstring
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

	// +=���Z�q�̃I�[�o�[���[�h TString = TString
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

	// +=�����ϊ����Z�q�̃I�[�o�[���[�h TString += char*
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

	// +=�����ϊ����Z�q�̃I�[�o�[���[�h TString += WCHAR*
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

	// +=�����ϊ����Z�q�̃I�[�o�[���[�h TString += string
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

	// +=�����ϊ����Z�q�̃I�[�o�[���[�h TString += wstring
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

	// []���Z�q�̃I�[�o�[���[�h
	TCHAR & operator[]( int idx )
	{
		#ifdef _UNICODE
			return wStr		[ idx ];
		#else
			return mbStr	[ idx ];
		#endif
	}

	// ==���Z�q�̃I�[�o�[���[�h
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

	// ==���Z�q�̃I�[�o�[���[�h
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

	// ==���Z�q�̃I�[�o�[���[�h
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

	// ==���Z�q�̃I�[�o�[���[�h
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

	// ==���Z�q�̃I�[�o�[���[�h
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

	// !=���Z�q�̃I�[�o�[���[�h
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

	// !=���Z�q�̃I�[�o�[���[�h
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

	// !=���Z�q�̃I�[�o�[���[�h
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

	// !=���Z�q�̃I�[�o�[���[�h
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

	// !=���Z�q�̃I�[�o�[���[�h
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
	//	�w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu��Ԃ��B�܂܂�Ȃ��Ȃ�-1��Ԃ�
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
	//	�w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu��Ԃ��B�܂܂�Ȃ��Ȃ�-1��Ԃ��iMBCS�j
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
	//	�w��̃L�[���[�h���܂܂�Ă����炻�̍ŏ��̈ʒu��Ԃ��B�܂܂�Ȃ��Ȃ�-1��Ԃ��iUNICODE�j
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
	//	�w��͈̔͂𕶎���Ŏ擾�iMBCS��UNICODE���̐ݒ�ɂ��ʒu���ω�����̂Œ��Ӂj
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
	//	�w��͈̔͂𕶎���Ŏ擾�iMBCS�ʒu�Ŏ擾�j
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
	//	�w��͈̔͂𕶎���Ŏ擾�iUNICODE�ʒu�Ŏ擾�j
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
	//	���j�R�[�h�����񂩂�}���`�o�C�g������֕ϊ�
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
	//	�}���`�o�C�g�����񂩂烆�j�R�[�h������֕ϊ�
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