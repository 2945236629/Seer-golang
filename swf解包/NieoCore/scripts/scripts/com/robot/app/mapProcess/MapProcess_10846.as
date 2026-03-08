package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   
   public class MapProcess_10846 extends BaseMapProcess
   {
      
      private var _choose:uint;
      
      public function MapProcess_10846()
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
         NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["缪斯......我并不是一个合格的父亲......我常常处在一种两难的选择当中，这一次，我要...."],["难道你还要功亏一篑吗？","你还天真的以为，这世上有比亲情更重要的东西吗？"],[function():void
         {
            _choose = 2;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,[".....既然不能在光明中生存，就让我在黑夜里叹息吧！"],["如果天蛇太祖，他杀了缪斯....."],[playMov2]);
         },function():void
         {
            _choose = 1;
            NpcDialog.show(NPC.LAO_TIAN_SHE_XING_MENG_ZHU,["亲情......我差点做出遗憾终生的事情！"],["那你现在知道该怎么做了？"],[playMov3]);
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
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("task_3049_1"),function():void
         {
            sendResult();
         });
      }
      
      private function sendResult() : void
      {
         SocketConnection.send(43587,2,this._choose);
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
      }
      
      private function hideAll() : void
      {
         LevelManager.iconLevel.visible = true;
         this.hideAllMov();
         MainManager.actorModel.visible = true;
      }
   }
}

