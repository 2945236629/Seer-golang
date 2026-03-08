package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.RescueZuoMeiSiController;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1249;
   import com.robot.app.task.taskscollection.Task1254;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_784 extends BaseMapProcess
   {
      
      private var _sptClickTimes:uint;
      
      public function MapProcess_784()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053236);
         SocketConnection.send(1022,86053238);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1249.initForMap784(this);
         Task1254.initForMap784(this);
         RescueZuoMeiSiController.init(this);
         this.initBoss();
      }
      
      private function initBoss() : void
      {
         this.bossMC.gotoAndStop(1);
         MapListenerManager.add(this.bossMC,this.onBossClick,"纳特");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         ++this._sptClickTimes;
         if(this._sptClickTimes <= 3)
         {
            AnimateManager.playMcAnimate(this.bossMC,this._sptClickTimes,"fire" + this._sptClickTimes,function():void
            {
               bossMC.gotoAndStop(_sptClickTimes + 1);
            });
         }
         else
         {
            NpcDialog.show(NPC.NATE,["什么人竟敢闯入恶灵深渊！你是想被我烧成灰烬吗？"],["让我见识一下你的强大吧！ ","我只是路过而已……"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("纳特");
            },function():void
            {
               bossMC.buttonMode = true;
               bossMC.gotoAndStop(1);
               _sptClickTimes = 0;
            }]);
         }
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         info = e.dataObj as FightOverInfo;
         this.bossMC.gotoAndStop(4);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.NATE,["看不出来，蛮有两下子嘛！我承认你的强大！"],["哈哈，谢谢！"],[function():void
            {
               bossMC.buttonMode = true;
               bossMC.gotoAndStop(1);
            }]);
         }
         else
         {
            NpcDialog.show(NPC.NATE,["我的胜利是必然的！不过我等待你的下一次挑战！"],["我一定会回来再次挑战你的！"],[function():void
            {
               bossMC.buttonMode = true;
               bossMC.gotoAndStop(1);
            }]);
         }
      }
      
      private function get bossMC() : MovieClip
      {
         if(MapManager.currentMap.controlLevel["sptBoss"] != null)
         {
            return MapManager.currentMap.controlLevel["sptBoss"];
         }
         return null;
      }
      
      override public function destroy() : void
      {
         this._sptClickTimes = 0;
         Task1249.destroy();
         RescueZuoMeiSiController.destroy();
      }
   }
}

