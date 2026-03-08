package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1231;
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
   
   public class MapProcess_780 extends BaseMapProcess
   {
      
      private var _sptClickTimes:uint;
      
      public function MapProcess_780()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053236);
         SocketConnection.send(1022,86053242);
         Task1231.initTaskFor780(this);
         this.initBoss();
      }
      
      private function initBoss() : void
      {
         this.bossMC.gotoAndStop(1);
         MapListenerManager.add(this.bossMC,this.onBossClick,"斯克鲁");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var frame:uint = 0;
         var e:MouseEvent = param1;
         ++this._sptClickTimes;
         if(this._sptClickTimes <= 3)
         {
            frame = uint(this._sptClickTimes + 1);
            AnimateManager.playMcAnimate(this.bossMC,frame,"mc" + frame,function():void
            {
               bossMC.gotoAndStop(frame + 1);
            });
         }
         else
         {
            NpcDialog.show(NPC.SIKELU,["我是魔神艾里克的忠实护卫！你有胆量挑战我吗？"],["让我见识一下你的强大吧！ ","我只是想看看你……"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("斯克鲁");
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
         this.bossMC.gotoAndStop(5);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.SIKELU,["看不出来，蛮有两下子嘛！我承认你的强大！"],["哈哈，谢谢！"],[function():void
            {
               bossMC.buttonMode = true;
               bossMC.gotoAndStop(1);
            }]);
         }
         else
         {
            NpcDialog.show(NPC.SIKELU,["我的胜利是必然的！不过我等待你的下一次挑战！"],["我一定会回来再次挑战你的！"],[function():void
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
         Task1231.destroy();
      }
   }
}

