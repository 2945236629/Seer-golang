package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_973 extends BaseMapProcess
   {
      
      public function MapProcess_973()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:DisplayObject = null;
         SocketConnection.send(1022,86067562);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.barrier.mouseEnabled = this.barrier.mouseChildren = false;
         ToolTipManager.add(conLevel["aruibosi"],"恐惧之神 阿瑞波斯");
         ToolTipManager.add(conLevel["aluonasi"],"风暴之神 阿洛纳斯");
         ToolTipManager.add(conLevel["dimoxisi"],"毁灭之神 迪莫西斯");
         ToolTipManager.add(conLevel["suolunsen"],"暗黑魔君 索伦森");
         var _loc1_:int = 0;
         while(_loc1_ < this.npcs.length)
         {
            _loc2_ = this.npcs[_loc1_];
            MapListenerManager.add(_loc2_ as InteractiveObject,this.onClick);
            _loc1_++;
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(BufferRecordManager.getMyState(993) == false)
         {
            getDefinitionByName("com.robot.app2.control.GameDeepCaveControl").playPreTask();
            return;
         }
         if(BufferRecordManager.getMyState(1014) == false)
         {
            getDefinitionByName("com.robot.app2.control.game.sorensenBattle.GameGodOfTheStorm").playPreTask();
            return;
         }
         if(BufferRecordManager.getMyState(1078) == false)
         {
            getDefinitionByName("com.robot.app2.control.game.sorensenBattle.GameSuolunsen").playPreTask();
            return;
         }
         switch(param1.target.name)
         {
            case "aruibosi":
               ModuleManager.showModule(ClientConfig.getAppModule("GodOfFearPanel"));
               break;
            case "aluonasi":
               ModuleManager.showModule(ClientConfig.getAppModule("GodOfStormPanel"));
               break;
            case "dimoxisi":
               ModuleManager.showModule(ClientConfig.getAppModule("GodOfDestructionPanel"));
               break;
            case "suolunsen":
               SocketConnection.send(1022,86070000);
               getDefinitionByName("com.robot.app2.control.game.sorensenBattle.GameSuolunsen").start();
         }
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["aruibosi"]);
         ToolTipManager.remove(conLevel["aluonasi"]);
         ToolTipManager.remove(conLevel["dimoxisi"]);
         ToolTipManager.remove(conLevel["suolunsen"]);
         super.destroy();
      }
      
      private function get npcs() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(MapManager.currentMap.controlLevel["aruibosi"]);
         _loc1_.push(MapManager.currentMap.controlLevel["aluonasi"]);
         _loc1_.push(MapManager.currentMap.controlLevel["dimoxisi"]);
         _loc1_.push(MapManager.currentMap.controlLevel["suolunsen"]);
         return _loc1_;
      }
      
      private function get barrier() : MovieClip
      {
         return MapManager.currentMap.controlLevel["barrier"];
      }
   }
}

