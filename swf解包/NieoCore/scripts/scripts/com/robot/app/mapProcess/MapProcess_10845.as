package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   
   public class MapProcess_10845 extends BaseMapProcess
   {
      
      private var _choose:uint;
      
      public function MapProcess_10845()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.hideAllMov();
         conLevel["mc1"].visible = true;
         this.playMov();
         AnimateManager.playMcAnimate(conLevel["mc1"],0,"",function():void
         {
            onNpcClick();
         });
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      private function onNpcClick() : void
      {
         NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["如今我才发现，当年让伊洛维奇入魔，也是组织上为了消灭妖王摩哥斯的安排，哈哈！我们都是棋子！现在，我给你这个改变历史的机会！"],["我不能允许任何善良堕落为邪恶！","那又如何？神已无力！魔渡众生！"],[function():void
         {
            _choose = 1;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["真好，陌生人，我希望你可以永远坚持你的信仰。"],["….如果…伊洛维奇没有入魔，那么他会…."],[playMov2]);
         },function():void
         {
            _choose = 2;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["看来，你并不打算改变什么。"],["如果伊洛维奇入魔，他会….."],[playMov3]);
         }]);
      }
      
      private function playMov2() : void
      {
         this.hideAllMov();
         conLevel["mc2"].visible = true;
         AnimateManager.playMcAnimate(conLevel["mc2"],0,"",function():void
         {
            sendResult();
         });
      }
      
      private function playMov3() : void
      {
         this.hideAllMov();
         conLevel["mc3"].visible = true;
         AnimateManager.playMcAnimate(conLevel["mc3"],0,"",function():void
         {
            sendResult();
         });
      }
      
      private function sendResult() : void
      {
         SocketConnection.send(43587,1,this._choose);
         this.hideAll();
         ModuleManager.showAppModule("ChangeHistoryPanel");
      }
      
      private function playMov() : void
      {
         LevelManager.iconLevel.visible = false;
         MainManager.actorModel.visible = false;
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
         MainManager.actorModel.visible = true;
      }
   }
}

