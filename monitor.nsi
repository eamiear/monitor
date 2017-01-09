;NSIS Modern User Interface
;Monitor Setup Script
;Unicode true

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Ӧ������
  Name "Monitor"
  ;�������
  OutFile "monitor-setup.exe"

  ;����Ĭ�ϰ�װ·��
  InstallDir "$PROGRAMFILES\monitor-win32-ia32"
  
  ;��ע����ȡ�ϴΰ�װ·��
  InstallDirRegKey HKCU "Software\monitor-win32-ia32" ""

  ;Windows VistaϵͳΪӦ�ó�������Ȩ��
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  ;�ڰ�װ�����а�"ȡ��"�Ļ��������Ƿ���ֹ��װ��ȷ�ϴ���
  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  ;!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  ;!insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "SimpChinese"

LoadLanguageFile "${NSISDIR}\Contrib\Language files\TradChinese.nlf"
;--------------------------------
;Version Information

  VIProductVersion "1.0.0.0"
  ;��Ʒ����
  VIAddVersionKey /LANG=${LANG_SimpChinese} "ProductName" "Monitor"
  ;��ע
  VIAddVersionKey /LANG=${LANG_SimpChinese} "Comments" "Monitor"
  ;��˾
  VIAddVersionKey /LANG=${LANG_SimpChinese} "CompanyName" "gosuncn"
  ;�Ϸ��̱�
  VIAddVersionKey /LANG=${LANG_SimpChinese} "LegalTrademarks" "Monitor"
  ;��Ȩ
  VIAddVersionKey /LANG=${LANG_SimpChinese} "LegalCopyright" "Copyright gosuncn"
  ;����
  VIAddVersionKey /LANG=${LANG_SimpChinese} "FileDescription" "Monitor Application"
  ;�ļ��汾��
  VIAddVersionKey /LANG=${LANG_SimpChinese} "FileVersion" "1.0.0"

;--------------------------------
;Installer Sections

Section ""

  ;�����·������Ϊ��װĿ¼
  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File /r "monitor-win32-ia32"

  ;���������ݷ�ʽ
  CreateShortCut "$DESKTOP\Monitor.lnk" "$INSTDIR\monitor-win32-ia32\monitor.exe" "" "$INSTDIR\monitor-win32-ia32\monitor.exe" 0

  ;������ʼ�˵���ݷ�ʽ
  CreateDirectory "$SMPROGRAMS\monitor-win32-ia32"
  CreateShortcut "$SMPROGRAMS\monitor-win32-ia32\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\monitor-win32-ia32\monitor.lnk" "$INSTDIR\monitor-win32-ia32\monitor.exe" "" "$INSTDIR\monitor-win32-ia32\monitor.exe" 0
  
  ;��ע���д�밲װ·��
  WriteRegStr HKCU "Software\monitor-win32-ia32" "" $INSTDIR
  WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\monitor-win32-ia32\monitor.exe" "RUNASADMIN"

  ;��ע���д��ж����Ϣ
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "DisplayName" "Monitor"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "NoRepair" 1
  
  ;����ж�س���
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  RMDir /r "$INSTDIR\monitor-win32-ia32"

  ;ɾ��ж�س���
  Delete "$INSTDIR\Uninstall.exe"

  ;ɾ�������ݷ�ʽ
  Delete "$DESKTOP\monitor.lnk"

  ;ɾ����ʼ�˵�Ŀ¼
  Delete "$SMPROGRAMS\monitor-win32-ia32\*.*"
  RMDir "$SMPROGRAMS\monitor-win32-ia32"
  ;ɾ����װĿ¼
  RMDir "$INSTDIR"

  ;ɾ��ע����
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32"
  DeleteRegKey /ifempty HKCU "Software\monitor-win32-ia32"

SectionEnd