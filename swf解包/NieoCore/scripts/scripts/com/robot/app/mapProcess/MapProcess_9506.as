package com.robot.app.mapProcess
{
   import com.robot.app.task.control.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.*;
   import flash.display.MovieClip;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_9506 extends BaseMapProcess
   {
      
      private static var isOpen:Boolean;
      
      private var gamePanel:MovieClip;
      
      public function MapProcess_9506()
      {
         super();
      }
      
      override protected function init() : void
      {
         isOpen = false;
         this.topLevel.mouseEnabled = false;
         this.topLevel.mouseChildren = false;
         this.initForAllTask();
      }
      
      override public function destroy() : void
      {
         this.destroyForAllTask();
      }
      
      private function initForAllTask() : void
      {
      }
      
      private function destroyForAllTask() : void
      {
         if(Boolean(this.gamePanel))
         {
            this.closeHandler();
         }
      }
      
      private function closeHandler(param1:MouseEvent = null) : void
      {
         this.gamePanel.visible = false;
         this.gamePanel.destroy();
         this.gamePanel.removeEventListener("success",this.successHandler);
         this.gamePanel["closeBTN"].removeEventListener(MouseEvent.CLICK,this.closeHandler);
         ToolTipManager.remove(this.gamePanel["starMC"]);
         this.gamePanel = null;
         this.topLevel.mouseEnabled = false;
         this.topLevel.mouseChildren = false;
      }
      
      private function successHandler(param1:Event) : void
      {
         var evt:Event = param1;
         isOpen = true;
         Alarm.show("石门已打开！",function():void
         {
            closeHandler();
            gotoDoor();
         });
         TasksManager.getProStatusList(TaskController_789.TASK_ID,function(param1:Array):void
         {
            if(Boolean(param1[0]) && Boolean(param1[1]) && !param1[2])
            {
               TasksManager.complete(789,2);
            }
         });
      }
      
      public function gotoDoor() : void
      {
         if(isOpen)
         {
            MapManager.changeMap(357);
            return;
         }
         if(this.gamePanel == null)
         {
            conLevel["kaxiusiMC"].gotoAndStop(1);
            this.gamePanel = this.topLevel["gamePanel"];
            this.gamePanel.addEventListener("success",this.successHandler);
            this.gamePanel["closeBTN"].addEventListener(MouseEvent.CLICK,this.closeHandler);
            this.gamePanel.init();
            this.gamePanel.visible = true;
            ToolTipManager.add(this.gamePanel["starMC"],"点击拖动碎片，放入形状相符的凹槽。");
            this.topLevel.mouseEnabled = true;
            this.topLevel.mouseChildren = true;
         }
      }
   }
}

