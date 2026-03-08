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
   
   public class MapProcess_10847 extends BaseMapProcess
   {
      
      private var _choose:uint;
      
      public function MapProcess_10847()
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
         NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["那剑的锋芒.....我是否真的要拦下他？"],["你为什么要去阻挡真正和平的到来？","一步错，步步错，如果你愿意满盘皆输的话！"],[function():void
         {
            _choose = 1;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["难道.....我真的已经败了？！我所付出的这些！都要支离破碎了吗？！"],[".....至少，他们还愿意承认你是他们的父亲。"],[playMov2]);
         },function():void
         {
            _choose = 2;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["不可能！之前漫长的等待都只是为了这一刻！我牺牲了这么多！甚至与自己的子女为敌！还不是为了此时此刻吗！"],["如果天蛇太祖，真的用尽全力的话......"],[playMov3]);
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
         SocketConnection.send(43587,3,this._choose);
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

