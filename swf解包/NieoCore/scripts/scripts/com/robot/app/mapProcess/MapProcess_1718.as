package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.MapStoryManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   
   public class MapProcess_1718 extends BaseMapProcess
   {
      
      public function MapProcess_1718()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.update();
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([124338],function(param1:Array):void
         {
            if(KTool.getBit(param1[0],24) > 0)
            {
               conLevel["boxBtn"].visible = false;
            }
            else
            {
               conLevel["boxBtn"].visible = true;
            }
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "boxBtn":
               MapStoryManager.dialog(172,22,function(param1:int):void
               {
                  var va:int = param1;
                  SocketConnection.sendByQueue(41900,[103,24],function(param1:*):void
                  {
                     update();
                  });
               });
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         super.destroy();
      }
   }
}

