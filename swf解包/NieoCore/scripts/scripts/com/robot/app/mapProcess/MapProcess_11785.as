package com.robot.app.mapProcess
{
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11785 extends BaseMapProcess
   {
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11785()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11785;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.initPos = new Point(401,372);
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      public function update(param1:* = null) : void
      {
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var _loc2_:int = int(param1.target.name.split("_")[1]);
         switch(param1.target.name)
         {
            case "btn":
               ModuleManager.showAppModule("ChristmasThemeMainPanel");
         }
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         ToolBarController.panel.visible = true;
      }
   }
}

