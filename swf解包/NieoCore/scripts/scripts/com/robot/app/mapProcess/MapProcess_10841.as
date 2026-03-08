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
   
   public class MapProcess_10841 extends BaseMapProcess
   {
      
      public function MapProcess_10841()
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
            conLevel["mc3"].visible = true;
            AnimateManager.playMcAnimate(conLevel["mc3"],0,"",function():void
            {
               hideAll();
               SocketConnection.sendWithCallback(43580,function():void
               {
                  ModuleManager.showAppModule("DYMHPanel");
               },4);
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
         NpcDialog.show(NPC.DIEN,["赛小息已经被我安全的撤离了，陌生人，这一次，你不需要协助他，但我需要你帮我选择。"],["选择什么？"],[function():void
         {
            NpcDialog.show(NPC.DIEN,["你知道，我的身份一直非常的尴尬，这种尴尬的身份伴随了我很久很久，我….我要摆脱。求你帮我，也算帮助整个赛尔号，可以吗？"],["….我要如何帮你？"],[function():void
            {
               NpcDialog.show(NPC.DIEN,["在正与邪之间，帮我选择一个。我要摆脱。求你帮我，也算帮助整个赛尔号，可以吗？"],["….我选正义。","我选邪恶。","我保留意见。"],[function():void
               {
                  hideAllMov();
                  conLevel["mc1"].visible = true;
                  playMov();
                  AnimateManager.playMcAnimate(conLevel["mc1"],0,"",function():void
                  {
                     SocketConnection.sendWithCallback(43580,function():void
                     {
                        hideAll();
                        ModuleManager.showAppModule("DYMHPanel");
                     },4);
                  });
               },function():void
               {
                  hideAllMov();
                  conLevel["mc2"].visible = true;
                  playMov();
                  AnimateManager.playMcAnimate(conLevel["mc2"],0,"",function():void
                  {
                     SocketConnection.sendWithCallback(43580,function():void
                     {
                        hideAll();
                        ModuleManager.showAppModule("DYMHPanel");
                     },4);
                  });
               },function():void
               {
                  NpcDialog.show(NPC.DIEN,["哦？保留意见，我问的问题你居然如此回答。那么就先陪我的精灵玩玩吧！"],["什么？！（进入战斗）"],[function():void
                  {
                     DYMHController.FightFlag = true;
                     SocketConnection.send(41129,3288);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function playMov() : void
      {
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.visible = false;
         conLevel["mc_npc"].visible = false;
      }
      
      private function hideAllMov() : void
      {
         conLevel["mc1"].visible = false;
         conLevel["mc2"].visible = false;
         conLevel["mc3"].visible = false;
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

