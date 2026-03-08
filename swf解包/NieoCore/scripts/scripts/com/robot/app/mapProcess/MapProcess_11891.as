package com.robot.app.mapProcess
{
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11891 extends BaseMapProcess
   {
      
      private var pos:Point;
      
      public function MapProcess_11891()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["npc_1"].addEventListener(MouseEvent.CLICK,this.onClick);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         MapManager.addEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(conLevel["npc_1"] != null && Boolean(conLevel["npc_1"].visible))
         {
            MainManager.actorModel.stop();
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
            MapManager.removeEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapClick);
            ModuleManager.showAppModule("EventCollectionPanel");
         }
      }
      
      private function onWalkEnter(param1:RobotEvent) : void
      {
         var _loc2_:Point = new Point();
         _loc2_ = MainManager.actorModel.parent.globalToLocal(conLevel["npc_1"].localToGlobal(new Point(0,0)));
         if(conLevel["npc_1"] && Point.distance(_loc2_,MainManager.actorModel.pos) < 100 && Boolean(conLevel["npc_1"].visible))
         {
            MainManager.actorModel.stop();
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
            MapManager.removeEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapClick);
         }
      }
      
      private function onMapClick(param1:MapEvent) : void
      {
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         MapManager.removeEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapClick);
      }
      
      override public function destroy() : void
      {
         if(MainManager.actorModel.hasEventListener(RobotEvent.WALK_ENTER_FRAME))
         {
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         }
         if(MapManager.hasEventListener(MapEvent.MAP_MOUSE_DOWN))
         {
            MapManager.removeEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapClick);
         }
         if(conLevel["npc_1"].hasEventListener(MouseEvent.CLICK))
         {
            conLevel["npc_1"].removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         super.destroy();
      }
   }
}

