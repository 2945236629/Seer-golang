package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1722 extends BaseMapProcess
   {
      
      private var bitDoor:Boolean = false;
      
      public function MapProcess_1722()
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
         if(this.bitDoor == false)
         {
            conLevel["door_0"].gotoAndStop(1);
         }
         else
         {
            conLevel["door_0"].gotoAndStop(3);
         }
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "gotoBailunhaoBtn":
               if(this.bitDoor == false)
               {
                  conLevel["door_0"].gotoAndStop(2);
                  AnimateManager.playMcAnimate(conLevel["door_0"],2,"ani",function():void
                  {
                     bitDoor = true;
                     conLevel["door_0"].gotoAndStop(3);
                     update();
                  });
                  break;
               }
               MapManager.changeMap(314);
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         super.destroy();
      }
   }
}

