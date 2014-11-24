@echo off
echo SQ RELEASE
Rem * 说明: FLEX_SDK配置SDK路径 RAREXE配置WinRAR路径 BASEDIR配置项目根路径 MODULE_LIST配置所有模块 MAIN_PUB可调整GameMain发布路径 *

set ISDEBUG=false
set FLEX_SDK="D:\anzhuangweizhi\fb\Adobe Flash Builder 4.6\sdks\4.6.0"
Set RAREXE=D:\anzhuangweizhi\winrar\WinRAR
set BASEDIR=E:\svnFile
set MODULE_SAVE_DIR=%BASEDIR%\Main\GameMain\asset\module

echo ...COMPC Common START
set COMMON_PUB="%BASEDIR%\Common\bin"
set COMMON_APP="%BASEDIR%\Common\src"
%FLEX_SDK%\bin\compc 	-swf-version=17 -target-player=11.1 -output=%COMMON_PUB%\Common.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
						-include-libraries+=%BASEDIR%\Common\libs -external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
						-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
						-static-link-runtime-shared-libraries=true -include-sources+=%COMMON_APP%
echo ...COMPC Common SUCCESSFUL

set UNZIPFILECOMMON=%COMMON_PUB%\Common.swc
%RAREXE% x %UNZIPFILECOMMON% %MODULE_SAVE_DIR%\ -y -IBCK
Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\Common.swf

echo ...MXMLC main START
set MAIN_PUB="%BASEDIR%\Main\GameMain\bin-release"
set MAIN_APP="%BASEDIR%\Main\GameMain\src\GameMain.as"
%FLEX_SDK%\bin\mxmlc 	-swf-version=17 -target-player=11.1 -output=%MAIN_PUB%\GameMain.swf -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
						-include-libraries+=%BASEDIR%\Main\GameMain\libs ^
						-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc -external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
						-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc -incremental=true -show-actionscript-warnings=true ^
						-static-link-runtime-shared-libraries=true %MAIN_APP%
echo ...MXMLC main SUCCESSFUL

Rem  ArenaRewardModule,MatchInfoModule,RoleRideModule,FindModule,
echo ...COMPC MODULES START
set MODULEDIR="%BASEDIR%\Module"
set MODULE_LIST=(FightModule,HelperModule,GuideModule,UndeadModule,UpgradeModule,WealthModule,OdinSelectModule,PrivateChatModule,OdinModule,ActivityModule,^
				ControlModule,EquipComposeModule,EquipModule,ExcitingModule,ExtendActivityModule,FriendExtendModule,FriendModule,EliteFBModule,GuideCityModule,^
				GuideSceneModule,LuckyDrawModule,MatchModule,RoleModule,SceneModule,SilveradooModule,TestModule,ArenaModule,ComposeModule,ChallengeCycleModule,^
				DriftBottleModule,MailModule,ShopModule,ChatModule,CheckPlayerInfoModule,PromptModule,AuditModule,BagModule,CopyModule,UnionModule,^
				MallModule,NewStoryModule,RingTaskModule,TaskModule,CopyLootModule,VIPModule,EffectModule,DailyActivityModule,AuditWinModule,^
				CopyTeamMainModule,CopyTeamOperateModule,VirtualDepotModule,ExtendMenuModule,WarehouseModule,DailyTaskModule,MapModule,QuizModule,RoleInfoModule,^
				CreateRoleModule,RankModule,MountModule,CopyTeamFightModule,SevenDayGiftModule,AlchemyModule,AuditPVPWinModule,NpcModule,ElitePassDrawModule,^
				MagicMirrorModule,ToolTipModule,DaZuoModule,DebugModule,UnionRingModule,CopyTeamPrizeModule,GodsFuryModule,LoadModule,ExchangeModule,MainMenuModule,^
				AuditLoseModule,LoginModule,ClimbTowerFightModule,ClimbTowerModule,CopyTeamPassModule,LevelGiftBagModule,MysticalShopModule,WorldBossModule,^
				GMModule,OnlineGiftModule,ProgressModule,ThoughtModule,TitleModule,TreasureModule)
for %%i in %MODULE_LIST% do (
   echo ......COMPC %%i TO %MODULEDIR%\%%i\bin\%%i.swc...
   %FLEX_SDK%\bin\compc -swf-version=17 -target-player=11.1 -output=%MODULEDIR%\%%i\bin\%%i.swc -optimize=true -strict=false -debug=%ISDEBUG% -locale=en_US^
						-include-libraries+=%MODULEDIR%\%%i\lib ^
						-external-library-path+=%BASEDIR%\Moebius\bin\Moebius.swc ^
						-external-library-path+=%BASEDIR%\Common\bin\Common.swc ^
						-external-library-path+=%FLEX_SDK%\frameworks\libs\player\11.1\playerglobal.swc ^
						-incremental=true -show-actionscript-warnings=true ^
						-static-link-runtime-shared-libraries=true -include-sources+=%MODULEDIR%\%%i\src

	%RAREXE% x %MODULEDIR%\%%i\bin\%%i.swc %MODULE_SAVE_DIR%\ -y -IBCK
	Move %MODULE_SAVE_DIR%\library.swf %MODULE_SAVE_DIR%\%%i.swf
)
Del %MODULE_SAVE_DIR%\*.xml
echo ...COMPC MODULES SUCCESSFUL

pause