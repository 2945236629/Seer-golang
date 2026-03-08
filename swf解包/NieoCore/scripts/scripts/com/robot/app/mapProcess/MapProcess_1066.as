package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_1066 extends BaseMapProcess
   {
      
      private var buttonMC:MovieClip;
      
      private var alarmMC:MovieClip;
      
      private var fun1:Function;
      
      private var fun2:Function;
      
      public function MapProcess_1066()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         i = 0;
         while(i < 4)
         {
            depthLevel["movePoint_" + i].visible = false;
            i++;
         }
         KTool.getMultiValue([1700],function(param1:Array):void
         {
            i = 0;
            while(i < 4)
            {
               if(i < param1[0])
               {
                  conLevel["boss_" + i].visible = false;
                  if(typeLevel["block_" + i])
                  {
                     DisplayUtil.removeForParent(typeLevel["block_" + i]);
                  }
                  DisplayUtil.stopAllMovieClip(conLevel["boss_" + i]);
               }
               else
               {
                  conLevel["boss_" + i].mouseChildren = false;
                  conLevel["boss_" + i].buttonMode = true;
                  conLevel["boss_" + i].addEventListener(MouseEvent.CLICK,onFight);
               }
               ++i;
            }
            MapManager.currentMap.makeMapArray();
         });
         this.buttonMC = MapManager.currentMap.libManager.getMovieClip("buttonMC");
         this.buttonMC.addEventListener(MouseEvent.CLICK,this.onButton);
         LevelManager.appLevel.addChild(this.buttonMC);
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         depthLevel.mouseChildren = false;
         depthLevel.mouseEnabled = false;
      }
      
      private function onFight(param1:MouseEvent) : void
      {
         var i:int = 0;
         var e:MouseEvent = param1;
         var a:Array = String(e.target.name).split("_");
         i = int(a[1]);
         MainManager.actorModel.moveAndAction(new Point(depthLevel["movePoint_" + i].x,depthLevel["movePoint_" + i].y),function():void
         {
            FightManager.fightNoMapBoss("",3348 + i);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               var info:FightOverInfo;
               var e:PetFightEvent = param1;
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               info = e.dataObj as FightOverInfo;
               if(info.winnerID != MainManager.actorID)
               {
                  KTool.getMultiValue([11641],function(param1:Array):void
                  {
                     var a:Array = param1;
                     if(a[0] >= getDefinitionByName("com.robot.app2.control.RosefinchEvoController").RETRY_TIMES)
                     {
                        Alarm.show("购买复活的次数达到上限！",function():void
                        {
                           MapManager.changeMap(1067);
                        });
                     }
                     else
                     {
                        showAlarm(1,function():void
                        {
                           KTool.buyProductByCallback(242690,1,function():void
                           {
                              KTool.doExchange(5061);
                              alarmMC.parent.removeChild(alarmMC);
                           });
                        },function():void
                        {
                           MapManager.changeMap(1067);
                        },a[0]);
                     }
                  });
               }
            });
         });
      }
      
      private function showAlarm(param1:int, param2:Function, param3:Function, param4:int = 0) : void
      {
         if(this.alarmMC == null)
         {
            this.alarmMC = MapManager.currentMap.libManager.getMovieClip("alarmMC");
            this.alarmMC.addEventListener(MouseEvent.CLICK,this.onAlarm);
         }
         this.alarmMC["mc"].gotoAndStop(param1);
         LevelManager.appLevel.addChild(this.alarmMC);
         this.fun1 = param2;
         this.fun2 = param3;
         if(param1 == 1)
         {
            this.alarmMC["mc"]["txt"].text = "您当前剩余复活次数：" + int(getDefinitionByName("com.robot.app2.control.RosefinchEvoController").RETRY_TIMES - param4);
         }
      }
      
      private function onButton(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target)
         {
            case this.buttonMC["cureBtn"]:
               PetManager.cureAll();
               break;
            case this.buttonMC["exitBtn"]:
               Alert.show("确定要离开吗？",function():void
               {
                  MapManager.changeMap(1067);
               });
         }
      }
      
      protected function onAlarm(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.alarmMC["yesBtn"]:
               this.fun1();
               break;
            case this.alarmMC["noBtn"]:
               this.fun2();
         }
      }
      
      override public function destroy() : void
      {
         this.buttonMC.removeEventListener(MouseEvent.CLICK,this.onButton);
         if(this.alarmMC)
         {
            this.alarmMC.removeEventListener(MouseEvent.CLICK,this.onAlarm);
         }
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["boss_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onFight);
            _loc1_++;
         }
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
         super.destroy();
      }
   }
}

