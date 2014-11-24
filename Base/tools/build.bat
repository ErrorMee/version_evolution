@echo off
echo SQ BUILD
Rem * ˵��: FLEX_SDK����SDK·�� RAREXE����WinRAR·�� BASEDIR������Ŀ��·�� MODULE_LIST��������ģ�� MAIN_PUB�ɵ���GameMain����·�� *

:ChoiceBuild
set /p ChoiceBuild=��ѡ��(Y��������,N������ֻ��ȡSWF):
if "%ChoiceBuild%"=="y" (
		echo ��ѡ���� ��������
		set BATBUILD=true
	) else (
		echo ��ѡ���� ������
		set BATBUILD=false
	)

if %BATBUILD%==false (
	goto NOCHIOCE
)

:ChoiceDebug
set /p ChoiceDebug=��ѡ��(Y����debug,N����release):
if "%ChoiceDebug%"=="y" (
		echo ��ѡ���� debug
		set ISDEBUG=true
		goto CHOICEEND
	) else (
		echo ��ѡ���� release
		set ISDEBUG=false
		goto CHOICEEND
	)

:NOCHIOCE
set ISDEBUG=false
:CHOICEEND

echo BATBUILD = %BATBUILD%
echo ISDEBUG = %ISDEBUG%

set FLEX_SDK="D:\anzhuangweizhi\fb\Adobe Flash Builder 4.6\sdks\4.6.0"
Set RAREXE=D:\anzhuangweizhi\winrar\WinRAR
set BASEDIR=E:\svnFile
set MODULE_SAVE_DIR=%BASEDIR%\Main\GameMain\asset\module

set COMMON_PUB="%BASEDIR%\Common\bin"
set COMMON_APP="%BASEDIR%\Common\src"
if %BATBUILD%==true (
	echo ...COMPC Common START
	%FLEX_SDK%\bin\compc 	-swf-version=17 -target-player=11.1 -output=%COMMON_PUB%\Common.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
							-include-libraries+=%BASEDIR%\Common\libs -external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
							-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
							-static-link-runtime-shared-libraries=true -include-sources+=%COMMON_APP%
	echo ...COMPC Common SUCCESSFUL
)

set UNZIPFILECOMMON=%COMMON_PUB%\Common.swc
%RAREXE% x %UNZIPFILECOMMON% %MODULE_SAVE_DIR%\ -y -IBCK
Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\Common.swf
echo %MODULE_SAVE_DIR%\Common.swf

set MAIN_PUB="%BASEDIR%\Main\GameMain\bin-release"
set MAIN_APP="%BASEDIR%\Main\GameMain\src\GameMain.as"
if %BATBUILD%==true (
	echo ...MXMLC main START
	%FLEX_SDK%\bin\mxmlc 	-swf-version=17 -target-player=11.1 -output=%MAIN_PUB%\GameMain.swf -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
							-include-libraries+=%BASEDIR%\Main\GameMain\libs ^
							-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc -external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
							-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
							-static-link-runtime-shared-libraries=true %MAIN_APP%
	echo ...MXMLC main SUCCESSFUL
)


Rem  ����ģ�� ArenaRewardModule,MatchInfoModule,RoleRideModule,FindModule,
Rem  set MODULE_LIST=(FightModule,HelperModule,GuideModule,UndeadModule,UpgradeModule,WealthModule,OdinSelectModule,PrivateChatModule,OdinModule,ActivityModule,^
Rem  				ControlModule,EquipComposeModule,EquipModule,ExcitingModule,ExtendActivityModule,FriendExtendModule,FriendModule,EliteFBModule,GuideCityModule,^
Rem  				GuideSceneModule,LuckyDrawModule,MatchModule,RoleModule,SceneModule,SilveradooModule,TestModule,ArenaModule,ComposeModule,ChallengeCycleModule,^
Rem  				DriftBottleModule,MailModule,ShopModule,ChatModule,CheckPlayerInfoModule,PromptModule,AuditModule,BagModule,CopyModule,UnionModule,^
Rem  				MallModule,NewStoryModule,RingTaskModule,TaskModule,CopyLootModule,VIPModule,EffectModule,DailyActivityModule,AuditWinModule,MainMenuModule,^
Rem  				CopyTeamMainModule,CopyTeamOperateModule,VirtualDepotModule,ExtendMenuModule,WarehouseModule,DailyTaskModule,MapModule,QuizModule,RoleInfoModule,^
Rem  				CreateRoleModule,RankModule,MountModule,CopyTeamFightModule,SevenDayGiftModule,AlchemyModule,AuditPVPWinModule,NpcModule,ElitePassDrawModule,^
Rem  				MagicMirrorModule,ToolTipModule,DaZuoModule,DebugModule,UnionRingModule,CopyTeamPrizeModule,GodsFuryModule,LoadModule,ExchangeModule,^
Rem  				AuditLoseModule,LoginModule,ClimbTowerFightModule,ClimbTowerModule,CopyTeamPassModule,LevelGiftBagModule,MysticalShopModule,WorldBossModule,^
Rem  				GMModule,OnlineGiftModule,ProgressModule,ThoughtModule,TitleModule,TreasureModule)
if %BATBUILD%==true (echo ...COMPC MODULES START)
set MODULEDIR="%BASEDIR%\Module"
set MODULE_LIST=(ControlModule,EquipComposeModule,EquipModule,ExcitingModule,ExtendActivityModule,FriendExtendModule,FriendModule,^
	HelperModule,OdinModule,OdinSelectModule,PrivateChatModule,UpgradeModule,WealthModule)

for %%i in %MODULE_LIST% do (
	if %BATBUILD%==true (
		echo ......COMPC %%i TO %MODULEDIR%\%%i\bin\%%i.swc...
   		%FLEX_SDK%\bin\compc -swf-version=17 -target-player=11.1 -output=%MODULEDIR%\%%i\bin\%%i.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
						-include-libraries+=%MODULEDIR%\%%i\lib ^
						-external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
						-external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
						-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc ^
						-incremental=true -show-actionscript-warnings=true ^
						-static-link-runtime-shared-libraries=true -include-sources+=%MODULEDIR%\%%i\src
	)

	%RAREXE% x %MODULEDIR%\%%i\bin\%%i.swc %MODULE_SAVE_DIR%\ -y -IBCK
	Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\%%i.swf
	echo %MODULE_SAVE_DIR%\%%i.swf
)
Del %MODULE_SAVE_DIR%\*.xml
if %BATBUILD%==true (echo ...COMPC MODULES SUCCESSFUL)
echo ...TASK SUCCESSFUL
pause