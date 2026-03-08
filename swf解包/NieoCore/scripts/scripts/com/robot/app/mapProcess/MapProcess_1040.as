package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.CommonUI;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_1040 extends BaseMapProcess
   {
      
      public static var lastProcess:int;
      
      public function MapProcess_1040()
      {
         super();
      }
      
      override public function destroy() : void
      {
         conLevel["bossMC"].removeEventListener(MouseEvent.CLICK,this.onFight);
         btnLevel.removeEventListener(MouseEvent.CLICK,this.onBtn);
         super.destroy();
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
      }
      
      private function onFight(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         FightManager.fightNoMapBoss("",2628);
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            var _loc3_:FightOverInfo = param1.dataObj as FightOverInfo;
            if(_loc3_.winnerID != MainManager.actorID)
            {
               ModuleManager.showModule(ClientConfig.getAppModule("DragonEvoRetryPanel"));
            }
         });
      }
      
      private function onBtn(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target)
         {
            case btnLevel["cureBtn"]:
               PetManager.cureAll();
               break;
            case btnLevel["exitBtn"]:
               Alert.show("确定要离开吗？",function():void
               {
                  MapManager.changeMap(1);
               });
         }
      }
      
      override protected function init() : void
      {
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         super.init();
         depthLevel.mouseChildren = false;
         depthLevel.mouseEnabled = false;
         conLevel["bossMC"].mouseChildren = false;
         conLevel["bossMC"].buttonMode = true;
         conLevel["bossMC"].addEventListener(MouseEvent.CLICK,this.onFight);
         btnLevel.addEventListener(MouseEvent.CLICK,this.onBtn);
         KTool.getMultiValue([6132],function(param1:Array):void
         {
            var crt:int = 0;
            var con:DisplayObjectContainer = null;
            var a:Array = param1;
            crt = int(a[0]);
            con = conLevel;
            if(crt == 0 && lastProcess == 0)
            {
               conLevel["bossMC"].gotoAndStop(1);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["bg"].gotoAndStop(1);
               AnimateManager.playMcAnimate(conLevel["mainMC"],1,"mc",function():void
               {
                  conLevel["mainMC"].visible = false;
                  conLevel["bossMC"].visible = true;
                  lastProcess = 1;
               });
            }
            else if(crt < 5)
            {
               lastProcess = 1;
               conLevel["bossMC"].gotoAndStop(1);
               conLevel["bossMC"].visible = true;
               conLevel["mainMC"].visible = false;
               conLevel["bg"].gotoAndStop(1);
               setTimeout(function():void
               {
                  var _loc1_:int = 0;
                  while(_loc1_ < 5)
                  {
                     if(crt > _loc1_)
                     {
                        CommonUI.setEnabled(con["bossMC"]["boss_" + _loc1_],false);
                     }
                     _loc1_++;
                  }
               },500);
            }
            else if(crt == 5 && lastProcess == 0)
            {
               conLevel["bossMC"].gotoAndStop(2);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["mainMC"].gotoAndStop(2);
               conLevel["bg"].gotoAndStop(1);
               AnimateManager.playMcAnimate(con["mainMC"],2,"mc",function():void
               {
                  con["mainMC"].visible = false;
                  con["bossMC"].visible = true;
                  lastProcess = 6;
               });
            }
            else if(crt == 5 && lastProcess <= 5)
            {
               conLevel["bossMC"].gotoAndStop(2);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["mainMC"].gotoAndStop(2);
               conLevel["bg"].gotoAndStop(1);
               EventManager.addEventListener(RobotEvent.FIGHT_OVER_UI_CLEAN,function(param1:RobotEvent):void
               {
                  var e:RobotEvent = param1;
                  AnimateManager.playMcAnimate(con["mainMC"],2,"mc",function():void
                  {
                     con["mainMC"].visible = false;
                     con["bossMC"].visible = true;
                     lastProcess = 6;
                  });
               });
            }
            else if(crt < 7)
            {
               lastProcess = 6;
               conLevel["bossMC"].gotoAndStop(2);
               conLevel["bossMC"].visible = true;
               conLevel["mainMC"].visible = false;
               conLevel["bg"].gotoAndStop(1);
               setTimeout(function():void
               {
                  if(crt == 6)
                  {
                     CommonUI.setEnabled(con["bossMC"]["boss_0"],false);
                  }
               },500);
            }
            else if(crt == 7 && lastProcess == 0)
            {
               conLevel["bossMC"].gotoAndStop(3);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["mainMC"].gotoAndStop(3);
               conLevel["bg"].gotoAndStop(2);
               AnimateManager.playMcAnimate(con["mainMC"],3,"mc",function():void
               {
                  con["mainMC"].visible = false;
                  con["bossMC"].visible = true;
                  lastProcess = 8;
               });
            }
            else if(crt == 7 && lastProcess <= 7)
            {
               conLevel["bossMC"].gotoAndStop(3);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["mainMC"].gotoAndStop(3);
               conLevel["bg"].gotoAndStop(2);
               EventManager.addEventListener(RobotEvent.FIGHT_OVER_UI_CLEAN,function(param1:RobotEvent):void
               {
                  var e:RobotEvent = param1;
                  AnimateManager.playMcAnimate(con["mainMC"],3,"mc",function():void
                  {
                     con["mainMC"].visible = false;
                     con["bossMC"].visible = true;
                     lastProcess = 8;
                  });
               });
            }
            else if(crt == 7)
            {
               conLevel["bossMC"].gotoAndStop(3);
               conLevel["bossMC"].visible = true;
               conLevel["mainMC"].visible = false;
               conLevel["bg"].gotoAndStop(2);
            }
            else if(crt >= 8)
            {
               conLevel["bossMC"].gotoAndStop(3);
               conLevel["bossMC"].visible = false;
               conLevel["mainMC"].visible = true;
               conLevel["mainMC"].gotoAndStop(3);
               conLevel["bg"].gotoAndStop(2);
               EventManager.addEventListener(RobotEvent.FIGHT_OVER_UI_CLEAN,function(param1:RobotEvent):void
               {
                  var e:RobotEvent = param1;
                  AnimateManager.playMcAnimate(con["mainMC"],4,"mc",function():void
                  {
                  });
               });
            }
         });
      }
   }
}

