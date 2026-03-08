package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_1360 extends BaseMapProcess
   {
      
      private static var laststep:int;
      
      private var ogres:Array;
      
      public function MapProcess_1360()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc3_:OgreModel = null;
         this.ogres = [];
         var _loc1_:Array = ["480|190","400|274","230|370"];
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = new OgreModel(_loc2_);
            _loc3_.show(554,new Point(int(_loc1_[_loc2_].split("|")[0]),int(_loc1_[_loc2_].split("|")[1])));
            this.ogres.push(_loc3_);
            _loc3_.addEventListener(MouseEvent.CLICK,this.clickHandle);
            _loc2_++;
         }
         this.check();
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         SocketConnection.sendByQueue(2411,[0,0]);
      }
      
      private function check() : void
      {
         var day:int = 0;
         day = int(SystemTimerManager.sysBJDate.date);
         KTool.getMultiValue([108000],function(param1:Array):void
         {
            if(MapProcess_1360.laststep == 1 && (day % 2 == 1 || KTool.getBit(param1[0],1) == 1) && (param1[0] >> 4 & 0x0F) == 2)
            {
               ModuleManager.showAppModule("GiftsfromMysteriousManS1Panel");
            }
            MapProcess_1360.laststep = param1[0] >> 4 & 0x0F;
         });
      }
      
      override public function destroy() : void
      {
         var _loc1_:OgreModel = null;
         if(this.ogres)
         {
            for each(_loc1_ in this.ogres)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.clickHandle);
               _loc1_.destroy();
               _loc1_ = null;
            }
            this.ogres = null;
         }
         super.destroy();
      }
   }
}

