package com.robot.app.mapProcess
{
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10115 extends BaseMapProcess
   {
      
      private var tool:MovieClip;
      
      private var oreMc:MovieClip;
      
      private var MagnumBtn:SimpleButton;
      
      private var getPetBtn:SimpleButton;
      
      public function MapProcess_10115()
      {
         super();
      }
      
      private static function get taskState() : uint
      {
         return TasksManager.getTaskStatus(1421);
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86055898);
         this.initMap();
         getDefinitionByName("com.robot.app2.control.MagnumCallController").stepForMap10115(this,this.initMap);
      }
      
      private function initMap() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         this.tool = conLevel["tool"] as MovieClip;
         this.oreMc = conLevel["oreMC"] as MovieClip;
         this.oreMc.buttonMode = true;
         this.MagnumBtn = conLevel["MagnumBtn"] as SimpleButton;
         this.getPetBtn = conLevel["getPetBtn"] as SimpleButton;
         this.tool.visible = false;
         if(taskState == TasksManager.COMPLETE)
         {
            this.oreMc.visible = true;
            this.getPetBtn.visible = true;
            this.oreMc.addEventListener(MouseEvent.CLICK,this.onCollent);
            this.MagnumBtn.addEventListener(MouseEvent.CLICK,this.onClick);
            this.getPetBtn.addEventListener(MouseEvent.CLICK,this.onGetPet);
            ToolTipManager.add(this.oreMc,"梦龙晶石");
         }
         else
         {
            this.oreMc.visible = false;
            this.getPetBtn.visible = false;
         }
      }
      
      private function onGetPet(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86055894);
         ModuleManager.showModule(ClientConfig.getTaskModule("MagnumGetPanel"));
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SocketConnection.send(1022,86055892);
         ModuleManager.showModule(ClientConfig.getTaskModule("MagnumCallPanel"));
      }
      
      private function onCollent(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.tool.visible = true;
         AnimateManager.playMcAnimate(this.tool,1,"mc",function():void
         {
            SocketConnection.addCmdListener(CommandID.MAGNUM_GETSTORE,onGetStore);
            SocketConnection.send(CommandID.MAGNUM_GETSTORE);
         });
      }
      
      private function onGetStore(param1:SocketEvent) : void
      {
         this.tool["mc"].gotoAndStop(1);
         this.tool.visible = false;
         Alarm.show("恭喜你获得一颗梦龙晶石！");
      }
      
      override public function destroy() : void
      {
         this.oreMc.removeEventListener(MouseEvent.CLICK,this.onCollent);
         this.MagnumBtn.removeEventListener(MouseEvent.CLICK,this.onClick);
         this.getPetBtn.removeEventListener(MouseEvent.CLICK,this.onGetPet);
         this.tool = null;
         this.oreMc = null;
         this.MagnumBtn = null;
         ToolTipManager.remove(this.oreMc);
         getDefinitionByName("com.robot.app2.control.MagnumCallController").destroy();
      }
   }
}

