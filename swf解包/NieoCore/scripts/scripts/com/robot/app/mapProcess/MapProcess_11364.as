package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialogNew_1;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MapProcess_11364 extends BaseMapProcess
   {
      
      private var curState:int = 0;
      
      private var timeOutValue:int = 0;
      
      public function MapProcess_11364()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([100719],function(param1:Array):void
         {
            if(KTool.subByte(param1[0],4,4) == 0)
            {
               SocketConnection.send(42306,6,2);
            }
            conLevel.addEventListener(MouseEvent.CLICK,onMouseClick);
         });
         LevelManager.toolsLevel.visible = false;
         LevelManager.iconLevel.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(e.target.name == "btn_1")
         {
            if(this.curState == 0)
            {
               NpcDialogNew_1.show(2595,["弱者有什么资格和强者平分一切？如果你没有能力，就无法开启噬魂法阵！"],["我可以的！（进入对战）","有点虚......"],[function():void
               {
                  FightManager.fightNoMapBoss("天邪龙皇",8002,false,true,function():void
                  {
                     if(FightManager.isWin)
                     {
                        curState = 1;
                        conLevel["mc"].gotoAndStop(1);
                        ModuleManager.showAppModule("MoreGiftForNationDayAwardPanel");
                     }
                  });
               },function():void
               {
               }]);
            }
            if(this.curState == 1)
            {
               NpcDialogNew_1.show(2595,["请耐心等待。"],["好！"]);
            }
         }
         if(e.target.name == "close")
         {
            MapManager.changeMapWithCallback(1,function():void
            {
            });
         }
      }
      
      private function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([100721],function(param1:Array):void
         {
            var leftTime:int = 0;
            var a:Array = param1;
            leftTime = a[0] + 5 * 60 - SystemTimerManager.sysBJDate.time / 1000;
            if(leftTime > 0)
            {
               MapManager.currentMap.controlLevel["mc"].gotoAndStop(conLevel["mc"].totalFrames);
               MapManager.currentMap.controlLevel["mc"].addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
               {
                  param1.currentTarget.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
                  showLeftTime(leftTime);
               });
            }
         });
      }
      
      private function showLeftTime(param1:int) : void
      {
         var curDate:Date = null;
         var leftTime:int = param1;
         clearTimeout(this.timeOutValue);
         if(leftTime <= 0)
         {
            curDate = SystemTimerManager.sysBJDate;
            if(curDate.date == 2 && curDate.hours == 15 && curDate.minutes >= 30)
            {
               SocketConnection.sendWithCallback(42306,function():void
               {
                  ModuleManager.showAppModule("MoreGiftForNationDayPanel");
               },5,2);
            }
            else
            {
               ModuleManager.showAppModule("MoreGiftForNationDayAwardPanel");
            }
         }
         else if(MapManager.currentMap.controlLevel != null && MapManager.currentMap.controlLevel["mc"] != null)
         {
            MapManager.currentMap.controlLevel["mc"]["txt_1"].text = "0" + int(leftTime / 60) + ":" + (leftTime % 60 < 10 ? "0" + int(leftTime % 60) : int(leftTime % 60));
            this.timeOutValue = setTimeout(this.showLeftTime,1000,leftTime - 1);
         }
      }
      
      override public function destroy() : void
      {
         clearTimeout(this.timeOutValue);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
      }
   }
}

