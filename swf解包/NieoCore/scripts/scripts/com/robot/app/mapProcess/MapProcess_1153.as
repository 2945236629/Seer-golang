package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_1153 extends BaseMapProcess
   {
      
      private var left:Boolean = false;
      
      private var right:Boolean = false;
      
      public function MapProcess_1153()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["goBtn_0"],"X战队密室");
         (conLevel["goBtn_0"] as MovieClip).buttonMode = true;
         ToolTipManager.add(conLevel["goBtn_1"],"六界神王殿");
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["leftDoorBtn"].buttonMode = true;
         conLevel["rightDoorBtn"].buttonMode = true;
         conLevel["leftDoorBtn"].addEventListener(MouseEvent.CLICK,this.onleftDoorClick);
         conLevel["rightDoorBtn"].addEventListener(MouseEvent.CLICK,this.onrightDoorClick);
         this.update();
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         switch(event.target.name)
         {
            case "goBtn_0":
               ModuleManager.showAppModule("XTeamH5toFlashMainPanel");
               break;
            case "goBtn_1":
               ModuleManager.showAppModule("SixKingOfGodPalaceMainPanel");
               break;
            case "openAppBtn_0":
               ModuleManager.showAppModule("BraveTowerPanel");
               break;
            case "openAppBtn_1":
               Alarm.show("请前往《赛尔号经典版》，体验最新《星际迷航》副本！",function():void
               {
                  navigateToURL(new URLRequest("http://seerh5.61.com/home/"),"_blank");
               });
               break;
            case "doorBtn":
               MapManager.changeMap(1147);
               break;
            case "gogoingBtn":
               MapManager.changeMap(10032);
         }
      }
      
      private function onleftDoorClick(param1:MouseEvent) : void
      {
         if(conLevel["leftDoorBtn"].currentFrame == 1)
         {
            conLevel["leftDoorBtn"].gotoAndStop(2);
            this.left = true;
            this.update();
            conLevel["leftDoorBtn"].buttonMode = false;
         }
      }
      
      private function onrightDoorClick(param1:MouseEvent) : void
      {
         if(conLevel["rightDoorBtn"].currentFrame == 1)
         {
            conLevel["rightDoorBtn"].gotoAndStop(2);
            this.right = true;
            this.update();
            conLevel["rightDoorBtn"].buttonMode = false;
         }
      }
      
      private function update() : void
      {
         if(this.left && this.right)
         {
            conLevel["gogoingBtn"].visible = true;
            conLevel["gogoingBtn"].buttonMode = true;
         }
         else
         {
            conLevel["gogoingBtn"].visible = false;
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         conLevel["leftDoorBtn"].removeEventListener(MouseEvent.CLICK,this.onleftDoorClick);
         conLevel["rightDoorBtn"].removeEventListener(MouseEvent.CLICK,this.onrightDoorClick);
         super.destroy();
      }
   }
}

