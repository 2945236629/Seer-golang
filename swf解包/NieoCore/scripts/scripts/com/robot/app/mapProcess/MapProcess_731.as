package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.games.GameStorageManager;
   import com.robot.app.spt.FightBossController;
   import com.robot.app.task.taskscollection.Task1061;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_731 extends BaseMapProcess
   {
      
      public function MapProcess_731()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,84806645);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task1061.initTaskForMap731(this);
         conLevel["sptboss"].addEventListener(MouseEvent.CLICK,this.onSptBossClick);
         conLevel["sptboss"].mouseChildren = false;
         conLevel["sptboss"].gotoAndStop(3);
         conLevel["sptboss"].buttonMode = true;
         ToolTipManager.add(btnLevel["shiban"],"石门迷阵");
         ToolTipManager.add(conLevel["sptboss"],"普兰特");
         btnLevel["shiban"].addEventListener(MouseEvent.CLICK,this.onStoneLLK);
      }
      
      private function onSptBossClick(param1:MouseEvent) : void
      {
         var target:MovieClip = null;
         var e:MouseEvent = param1;
         target = e.currentTarget as MovieClip;
         if(target.currentFrame == 3)
         {
            AnimateManager.playMcAnimate(target,3,"mc3",function():void
            {
               target.gotoAndStop(1);
               fightWithBoss();
            });
         }
         else
         {
            this.fightWithBoss();
         }
      }
      
      private function fightWithBoss() : void
      {
         NpcDialog.show(NPC.PULANTE,["米娜村，是我的全部，为了村落我要一直战斗下去！小子，来挑战我吧！我会让你知道如何战斗！"],["我要挑战你！","我等会再来！"],[function():void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,onFightFinish);
            FightBossController.fightBoss("普兰特");
         },function():void
         {
            AnimateManager.playMcAnimate(conLevel["sptboss"],2,"mc2",function():void
            {
               conLevel["sptboss"].gotoAndStop(3);
            });
         }]);
      }
      
      private function onFightFinish(param1:PetFightEvent) : void
      {
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightFinish);
         var _loc2_:FightOverInfo = param1.dataObj as FightOverInfo;
         if(_loc2_.winnerID == MainManager.actorID)
         {
            NpcDialog.show(NPC.PULANTE,["果然年轻有为啊！你已经可以独当一面的，你现在可以离开这里了！"],["放心吧！我会帮助米娜村的！"]);
         }
         else
         {
            NpcDialog.show(NPC.PULANTE,["小子，你还得多多努力啊！相信通过你的努力一定会更加强大的！"],["继续修炼！"]);
         }
      }
      
      private function onStoneLLK(param1:MouseEvent) : void
      {
         MapManager.removeAppArrow();
         GameStorageManager.freshLastGame(41012);
         GameStartController.show("StoneLLKStart","StoneLLKGame");
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["sptboss"]);
         ToolTipManager.remove(btnLevel["shiban"]);
         btnLevel["shiban"].removeEventListener(MouseEvent.CLICK,this.onStoneLLK);
         Task1061.destroy();
      }
   }
}

