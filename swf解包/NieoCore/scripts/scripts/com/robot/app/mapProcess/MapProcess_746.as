package com.robot.app.mapProcess
{
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1131;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_746 extends BaseMapProcess
   {
      
      public function MapProcess_746()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initBoss();
         Task1131.initTaskFor746(this);
      }
      
      private function initBoss() : void
      {
         ToolTipManager.add(this.bossMC,"巴索尔");
         this.bossMC.buttonMode = true;
         this.bossMC.addEventListener(MouseEvent.CLICK,this.onBossClick);
      }
      
      private function onBossClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.bossMC.buttonMode = false;
         AnimateManager.playMcAnimate(this.bossMC,2,"mc",function():void
         {
            NpcDialog.show(NPC.BASUOER,["什么！居然被你发现光能量的秘密，看来你一定不是泛泛之辈！既然你知道了0xff0000守护残殿的秘密，想必一定是入侵者，0xffffff那么就来较量一下吧！"],["我正有此意！","让我先准备一下！"],[function():void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
               FightBossController.fightBoss("巴索尔");
            },function():void
            {
               bossMC.gotoAndStop(4);
               AnimateManager.playMcAnimate(bossMC,4,"mc",function():void
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
         if(info.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.BASUOER,["太不可思议了，你居然有如此强大的实力！这样就有希望了..."],["什么有希望啦？"],[function():void
            {
               bossMC.gotoAndStop(3);
               AnimateManager.playMcAnimate(bossMC,3,"mc",function():void
               {
                  bossMC.buttonMode = true;
                  bossMC.gotoAndStop(1);
               });
            }]);
         }
         else
         {
            NpcDialog.show(NPC.BASUOER,["你已经尽力了，看来这里不适合你，还是快走吧！我正在等待救世主的出现！"],["可恶，我还会努力的！"],[function():void
            {
               bossMC.gotoAndStop(4);
               AnimateManager.playMcAnimate(bossMC,4,"mc",function():void
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
         ToolTipManager.remove(this.bossMC);
         this.bossMC.removeEventListener(MouseEvent.CLICK,this.onBossClick);
         Task1131.destroy();
      }
   }
}

