package com.robot.app.mapProcess
{
   import com.robot.app.control.GameStartController;
   import com.robot.app.task.taskUtils.manage.TaskDiaLogManager;
   import com.robot.app.task.taskUtils.taskDialog.TaskMod;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_11377 extends BaseMapProcess
   {
      
      public function MapProcess_11377()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(this.gameBtn,"粽仔祖玛");
         ToolTipManager.add(conLevel["kaimila"],"凯米拉");
         conLevel["kaimila"].buttonMode = true;
         conLevel["kaimila"].addEventListener(MouseEvent.CLICK,this.onKaiMiLaClick);
      }
      
      private function onKaiMiLaClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var taskMod:TaskMod = new TaskMod(TaskDiaLogManager.DIALOG,NPC.KAIMILA,["好久没人来看望过我了，见到你真好！欢迎来到幻海遗城,希望还能再次看到你！"],["谢谢！"]);
         taskMod.isNewDialog_1 = true;
         TaskDiaLogManager.single.playStory([taskMod],function():void
         {
            MapManager.changeMapWithCallback(1,function():void
            {
               SocketConnection.send(45693,14,1);
               ModuleManager.showAppModule("ZLWSGetYellowPanel");
            });
         });
      }
      
      private function onGame(param1:MouseEvent) : void
      {
         MapManager.removeAppArrow();
         GameStartController.show("ZumaStart","ZumaGame");
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

