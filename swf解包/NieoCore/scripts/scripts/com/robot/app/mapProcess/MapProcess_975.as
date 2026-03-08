package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   
   public class MapProcess_975 extends BaseMapProcess
   {
      
      private const _npcTips:Array = ["白羽剑魂特兰西","赤焰战魂金斯特","紫金斗魂拉塞尔"];
      
      public function MapProcess_975()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc2_:DisplayObject = null;
         if(BufferRecordManager.getMyState(1001) == false)
         {
            conLevel["npcs"].visible = false;
         }
         SocketConnection.send(1022,86067752);
         var _loc1_:int = 0;
         while(_loc1_ < this.npcs.length)
         {
            _loc2_ = this.npcs[_loc1_];
            MapListenerManager.add(_loc2_ as InteractiveObject,this.onNpcClick,this._npcTips[_loc1_]);
            _loc1_++;
         }
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "trancy":
               ModuleManager.showModule(ClientConfig.getAppModule("TrancyFightPanel"));
               break;
            case "jinsite":
               ModuleManager.showModule(ClientConfig.getAppModule("JinsiteFightPanel"));
               break;
            case "lasaier":
               ModuleManager.showModule(ClientConfig.getAppModule("LasaierFightPanel"));
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
      
      private function get npcs() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(conLevel["trancy"]);
         _loc1_.push(conLevel["jinsite"]);
         _loc1_.push(conLevel["lasaier"]);
         return _loc1_;
      }
   }
}

