package com.robot.app.mapProcess
{
   import com.robot.app.control.DYMHController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.events.MouseEvent;
   
   public class MapProcess_10840 extends BaseMapProcess
   {
      
      public function MapProcess_10840()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(DYMHController.FightFlag)
         {
            DYMHController.FightFlag = false;
            this.hideAllMov();
            conLevel["mc_npc"].visible = false;
            conLevel["mc_npc"].buttonMode = false;
            conLevel["mc1"].visible = true;
            AnimateManager.playMcAnimate(conLevel["mc1"],0,"",function():void
            {
               NpcDialog.show(NPC.BITEDAREN,["你现在一定想要叫醒赛小息，从我看到你的第一眼，就知道你是来找他的。这次的战斗将由我主导，至于Neo的第三个疑惑，我已经帮他解决了。"],[" "],[function():void
               {
                  SocketConnection.sendWithCallback(43580,function():void
                  {
                     hideAll();
                     ModuleManager.showAppModule("DYMHPanel");
                  },3);
               }]);
            });
         }
         else
         {
            this.hideAllMov();
            conLevel["mc_npc"].visible = true;
            conLevel["mc_npc"].buttonMode = true;
            conLevel["mc_npc"].addEventListener(MouseEvent.CLICK,this.onNpcClick);
         }
      }
      
      override public function destroy() : void
      {
         conLevel["mc_npc"].removeEventListener(MouseEvent.CLICK,this.onNpcClick);
         super.destroy();
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.SEER,["你要做什么？"],["我？嘿嘿，我可是比特大人。"],[function():void
         {
            NpcDialog.show(NPC.BITEDAREN,["你是来帮助赛小息的？"],["不不，我不认识他。","是的，我是来帮助赛小息的。"],[function():void
            {
               NpcDialog.show(NPC.BITEDAREN,["既然你不认识他，为何要来这里捣乱？难道你的能力已经强大到可以无视海盗舰队的境界了？看来似乎是这样，那我就不客气了。"],["来吧！（进入战斗）","….不不，我走我走。"],[function():void
               {
                  DYMHController.FightFlag = true;
                  SocketConnection.send(41129,3287);
               },function():void
               {
               }]);
            },function():void
            {
               NpcDialog.show(NPC.BITEDAREN,["帮他？你对你的能力已经如此自信了吗？我可是比特大人，我让你做不成的事情，你就无法做成！"],["是吗？那我们只好试一试了！（进入对战）"],[function():void
               {
                  DYMHController.FightFlag = true;
                  SocketConnection.send(41129,3287);
               }]);
            }]);
         }]);
      }
      
      private function playMov() : void
      {
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.visible = false;
      }
      
      private function hideAllMov() : void
      {
         conLevel["mc1"].visible = false;
      }
      
      private function hideAll() : void
      {
         LevelManager.iconLevel.visible = true;
         this.hideAllMov();
         conLevel["mc_npc"].visible = false;
         MainManager.actorModel.visible = true;
      }
   }
}

