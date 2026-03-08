package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_1189 extends BaseMapProcess
   {
      
      public function MapProcess_1189()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["mc_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onMcClick);
            conLevel["mc_" + _loc1_].visible = false;
            conLevel["mc_" + _loc1_].buttonMode = true;
            _loc1_++;
         }
         this.update();
      }
      
      public function onMcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         var index:int = int(event.currentTarget.name.split("_")[1]);
         SocketConnection.addCmdListener(41259,function(param1:SocketEvent):void
         {
            SocketConnection.removeCmdListener(41259,arguments.callee);
            var _loc3_:int = 0;
            while(_loc3_ < 4)
            {
               conLevel["mc_" + _loc3_].visible = false;
               _loc3_++;
            }
         });
         SocketConnection.send(41259,9);
      }
      
      private function update() : void
      {
         KTool.getMultiValue([11098],function(param1:Array):void
         {
            var _loc2_:int = 0;
            if(param1[0] < 15)
            {
               if(int(Math.random() * 100) < 20)
               {
                  _loc2_ = int(Math.random() * 5);
                  if(Boolean(conLevel) && Boolean(conLevel["mc_" + _loc2_]))
                  {
                     conLevel["mc_" + _loc2_].visible = true;
                  }
               }
            }
         });
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["mc_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onMcClick);
            _loc1_++;
         }
         super.destroy();
      }
   }
}

