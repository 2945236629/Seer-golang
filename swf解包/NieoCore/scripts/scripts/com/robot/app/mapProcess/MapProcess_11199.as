package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class MapProcess_11199 extends BaseMapProcess
   {
      
      private const totalTim:int = 3;
      
      private var tim:int = 0;
      
      private var _timeInterval:uint = 0;
      
      public function MapProcess_11199()
      {
         super();
      }
      
      override protected function init() : void
      {
         depthLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         LevelManager.iconLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         clearInterval(this._timeInterval);
      }
      
      private function addTime(param1:int) : void
      {
         this.tim = param1;
         depthLevel["good"].gotoAndStop(2);
         depthLevel.addEventListener(Event.FRAME_CONSTRUCTED,this.onFramConstructed);
      }
      
      private function onFramConstructed(param1:Event) : void
      {
         if(depthLevel.getChildAt(depthLevel.numChildren - 1) == null)
         {
            return;
         }
         depthLevel.removeEventListener(Event.FRAME_CONSTRUCTED,this.onFramConstructed);
         this.showTime();
         this._timeInterval = setInterval(this.showTime,1000);
      }
      
      private function showTime() : void
      {
         var _loc1_:String = null;
         if(this.tim < 0)
         {
            clearInterval(this._timeInterval);
            depthLevel["good"].gotoAndStop(3);
         }
         else
         {
            _loc1_ = this.tim % 60 >= 10 ? String(this.tim % 60) : "0" + String(this.tim % 60);
            depthLevel["good"]["txt_1"].text = "0" + int(this.tim / 60) + ":" + _loc1_;
            depthLevel["good"]["mcBar"]["mcBar"].gotoAndStop(int(100 * (this.totalTim - this.tim) / this.totalTim));
         }
         --this.tim;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var goodArr:Array = null;
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "good":
               this.addTime(this.totalTim);
               break;
            case "award":
               depthLevel["good"].gotoAndStop(1);
               goodArr = [1708958];
               ItemManager.updateItems(goodArr,function():void
               {
                  if(ItemManager.getNumByID(goodArr[0]) >= 1)
                  {
                     Alarm.show("你已经采集过了");
                     depthLevel["good"].visible = false;
                  }
                  else
                  {
                     SocketConnection.sendWithCallback(42531,function():void
                     {
                        KTool.getBitSet([1660],function(param1:Array):void
                        {
                           if(param1[0] == 0)
                           {
                              Alarm.show("此次采集失败了！最多采集3次必定获得！");
                           }
                           else
                           {
                              LevelManager.iconLevel.mouseEnabled = true;
                              depthLevel["good"].visible = false;
                           }
                        });
                     },2);
                  }
               });
         }
      }
   }
}

