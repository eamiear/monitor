;NSIS Modern User Interface
;Monitor Setup Script
;Unicode true

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;应用名称
  Name "Monitor"
  ;输出名称
  OutFile "monitor-setup.exe"

  ;设置默认安装路径
  InstallDir "$PROGRAMFILES\monitor-win32-ia32"
  
  ;从注册表检取上次安装路径
  InstallDirRegKey HKCU "Software\monitor-win32-ia32" ""

  ;Windows Vista系统为应用程序请求权限
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  ;在安装过程中按"取消"的话，弹出是否终止安装的确认窗口
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
  ;产品名称
  VIAddVersionKey /LANG=${LANG_SimpChinese} "ProductName" "Monitor"
  ;备注
  VIAddVersionKey /LANG=${LANG_SimpChinese} "Comments" "Monitor"
  ;公司
  VIAddVersionKey /LANG=${LANG_SimpChinese} "CompanyName" "gosuncn"
  ;合法商标
  VIAddVersionKey /LANG=${LANG_SimpChinese} "LegalTrademarks" "Monitor"
  ;版权
  VIAddVersionKey /LANG=${LANG_SimpChinese} "LegalCopyright" "Copyright gosuncn"
  ;描述
  VIAddVersionKey /LANG=${LANG_SimpChinese} "FileDescription" "Monitor Application"
  ;文件版本号
  VIAddVersionKey /LANG=${LANG_SimpChinese} "FileVersion" "1.0.0"

;--------------------------------
;Installer Sections

Section ""

  ;将输出路径设置为安装目录
  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File /r "monitor-win32-ia32"

  ;创建桌面快捷方式
  CreateShortCut "$DESKTOP\Monitor.lnk" "$INSTDIR\monitor-win32-ia32\monitor.exe" "" "$INSTDIR\monitor-win32-ia32\monitor.exe" 0

  ;创建开始菜单快捷方式
  CreateDirectory "$SMPROGRAMS\monitor-win32-ia32"
  CreateShortcut "$SMPROGRAMS\monitor-win32-ia32\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortcut "$SMPROGRAMS\monitor-win32-ia32\monitor.lnk" "$INSTDIR\monitor-win32-ia32\monitor.exe" "" "$INSTDIR\monitor-win32-ia32\monitor.exe" 0
  
  ;向注册表写入安装路径
  WriteRegStr HKCU "Software\monitor-win32-ia32" "" $INSTDIR
  WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\monitor-win32-ia32\monitor.exe" "RUNASADMIN"

  ;向注册表写入卸载信息
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "DisplayName" "Monitor"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32" "NoRepair" 1
  
  ;创建卸载程序
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  RMDir /r "$INSTDIR\monitor-win32-ia32"

  ;删除卸载程序
  Delete "$INSTDIR\Uninstall.exe"

  ;删除桌面快捷方式
  Delete "$DESKTOP\monitor.lnk"

  ;删除开始菜单目录
  Delete "$SMPROGRAMS\monitor-win32-ia32\*.*"
  RMDir "$SMPROGRAMS\monitor-win32-ia32"
  ;删除安装目录
  RMDir "$INSTDIR"

  ;删除注册表键
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\monitor-win32-ia32"
  DeleteRegKey /ifempty HKCU "Software\monitor-win32-ia32"

SectionEnd