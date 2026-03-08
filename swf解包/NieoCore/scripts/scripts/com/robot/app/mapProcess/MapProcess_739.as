package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_739 extends BaseMapProcess
   {
      
      public function MapProcess_739()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86059930);
         this.gameBtn.addEventListener(MouseEvent.CLICK,this.onGame);
         ToolTipManager.add(this.gameBtn,"保护花朵行动");
         ToolTipManager.add(conLevel["kaimila"],"凯米拉");
         conLevel["kaimila"].buttonMode = true;
         conLevel["kaimila"].addEventListener(MouseEvent.CLICK,this.onKaiMiLaClick);
      }
      
      private function onKaiMiLaClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,84806636);
         NpcDialog.show(NPC.KAIMILA,["ZZZZZZZZZZZZ（雷鸣般的鼾声）"],["哇，凯米拉的气势好强，还是别吵醒它！"]);
      }
      
      private function onGame(param1:MouseEvent) : void
      {
         MapManager.removeAppArrow();
         getDefinitionByName("com.robot.app2.mapProcess.control.WinterGameController").startZuma();
      }
      
      private function get gameBtn() : SimpleButton
      {
         return conLevel["gameBtn"];
      }
      
      override public function destroy() : void
      {
         this.gameBtn.removeEventListener(MouseEvent.CLICK,this.onGame);
         ToolTipManager.remove(this.gameBtn);
         ToolTipManager.remove(conLevel["kaimila"]);
         conLevel["kaimila"].removeEventListener(MouseEvent.CLICK,this.onKaiMiLaClick);
         super.destroy();
      }
   }
}

