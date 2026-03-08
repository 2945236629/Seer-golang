package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1166;
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
   
   public class MapProcess_762 extends BaseMapProcess
   {
      
      public function MapProcess_762()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         SocketConnection.send(1022,86053224);
         SocketConnection.send(1022,86053232);
         this.initBoss();
         Task1166.initTaskFor762(this);
      }
      
      private function initBoss() : void
      {
         MapListenerManager.add(this.bossMC,this.onBossClick,"帕里斯");
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.bossMC.buttonMode = false;
         AnimateManager.playMcAnimate(this.bossMC,2,"mc",function():void
         {
            NpcDialog.show(NPC.PALISI,["我乃恶魔星第五领域的王者，兽神—帕里斯！谁来与我大战三百回合！"],["让我来挑战你一下吧！","我先准备一下就来挑战你！"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("帕里斯");
            },function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
               });
            }]);
         });
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         var info:FightOverInfo;
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         info = e.dataObj as FightOverInfo;
         this.bossMC.gotoAndStop(3);
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.PALISI,["看不出来，你很有几下子嘛！有没有兴趣做我的小弟？"],["哈哈，你的好意我心领啦！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
               });
            }]);
         }
         else
         {
            NpcDialog.show(NPC.PALISI,["哼哼，你还太弱小了！去好好修炼一下再来挑战我吧！"],["我一定会回来再次挑战你的！"],[function():void
            {
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
               });
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
         Task1166.destroy();
      }
   }
}

