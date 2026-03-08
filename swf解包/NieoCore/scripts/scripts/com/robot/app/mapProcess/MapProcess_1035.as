package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.DisplayObjectContainer;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.taomee.effect.ColorFilter;
   import org.taomee.events.SocketEvent;
   import org.taomee.utils.BitUtil;
   
   public class MapProcess_1035 extends BaseMapProcess
   {
      
      private static var _conLevel:DisplayObjectContainer;
      
      private var _panelTime:Timer;
      
      private var cls:*;
      
      public function MapProcess_1035()
      {
         super();
      }
      
      public static function update() : void
      {
         KTool.getMultiValue([13524],function(param1:Array):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < 7)
            {
               if(BitUtil.getBit(param1[0],_loc2_) > 0)
               {
                  _conLevel["item_" + _loc2_].filters = [ColorFilter.setGrayscale()];
                  KTool.enableMC([_conLevel["item_" + _loc2_]],false);
                  _conLevel["item_" + _loc2_].visible = false;
               }
               else
               {
                  _conLevel["item_" + _loc2_].filters = null;
                  KTool.enableMC([_conLevel["item_" + _loc2_]],true);
               }
               _loc2_++;
            }
         });
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         _conLevel = conLevel;
         var _loc1_:int = 0;
         while(_loc1_ < 7)
         {
            conLevel["item_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onItemClick);
            conLevel["item_" + _loc1_].buttonMode = true;
            _loc1_++;
         }
         update();
      }
      
      private function onTime(param1:TimerEvent) : void
      {
         update();
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var index:int = int(event.currentTarget.name.split("_")[1]);
         SocketConnection.addCmdListener(45508,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(45508,arguments.callee);
            update();
         });
         SocketConnection.send(45508,index + 1);
      }
      
      private function onTatusMcClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("TsarZahnFernandezSuperEvolutionFurnacesPanel"),"正在打开...");
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["item_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onItemClick);
            _loc1_++;
         }
         if(_conLevel != null)
         {
            _conLevel = null;
         }
         if(this.cls != null)
         {
            this.cls.destroy();
         }
         super.destroy();
      }
   }
}

