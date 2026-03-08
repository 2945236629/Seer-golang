package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.ArrayUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_1207 extends BaseMapProcess
   {
      
      private var time:int;
      
      private var initd:Boolean = false;
      
      private var clicked:Boolean = false;
      
      private var pos:Array;
      
      private var hidenum:int;
      
      public function MapProcess_1207()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.pos = [];
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.pos.push(new Point(btnLevel["box_" + _loc1_].x,btnLevel["box_" + _loc1_].y));
            _loc1_++;
         }
         topLevel["movie"].visible = false;
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            btnLevel["box_" + _loc2_].addEventListener(MouseEvent.CLICK,this.clickHandle);
            btnLevel["box_" + _loc2_].visible = false;
            _loc2_++;
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var index:int;
         var e:MouseEvent = param1;
         var idx:int = int(e.currentTarget.name.split("_")[1]);
         btnLevel["box_" + idx].visible = false;
         index = int(getDefinitionByName("com.robot.app2.control.DaanHeitianCountermarkController").showidx.indexOf(idx));
         if(index != -1)
         {
            getDefinitionByName("com.robot.app2.control.DaanHeitianCountermarkController").showidx.splice(index,1);
         }
         ++this.hidenum;
         if(this.hidenum >= 5)
         {
            this.hidenum = 0;
            this.initd = false;
            getDefinitionByName("com.robot.app2.control.DaanHeitianCountermarkController").showidx = [0,1,2,3,4];
         }
         SocketConnection.sendByQueue(43202,[5,0],function(param1:SocketEvent):void
         {
            var e:SocketEvent = param1;
            KTool.getMultiValue([15263],function(param1:Array):void
            {
               switch(param1[0])
               {
                  case 1:
                     Alarm.show("你的手速慢了，流星雨奖励已不在这里！");
                     break;
                  case 2:
                     ModuleManager.showAppModule("DaanHeitianCountermarkevent1Panel",1);
                     break;
                  case 3:
                     ModuleManager.showAppModule("DaanHeitianCountermarkevent1Panel",2);
                     break;
                  case 4:
                     ModuleManager.showAppModule("DaanHeitianCountermarkevent2Panel",1);
                     break;
                  case 5:
                     ModuleManager.showAppModule("DaanHeitianCountermarkevent2Panel",2);
               }
            });
            timerHandle();
         },function(param1:*):void
         {
         });
      }
      
      protected function timerHandle() : void
      {
         var _loc1_:Date = SystemTimerManager.sysBJDate;
         var _loc2_:Date = new Date(2016,9,14);
         if(_loc1_.time < _loc2_.time)
         {
            if(_loc1_.hours >= 6 && _loc1_.hours <= 23 && _loc1_.minutes < 5)
            {
               if(!this.initd)
               {
                  this.showbox();
               }
               topLevel["movie"].visible = true;
            }
            else
            {
               this.initd = false;
               this.removeallBox();
               topLevel["movie"].visible = false;
            }
         }
         else
         {
            topLevel["movie"].visible = false;
            this.removeallBox();
         }
      }
      
      private function showbox() : void
      {
         this.pos = ArrayUtils.shuffle(this.pos);
         this.initd = true;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            btnLevel["box_" + _loc1_].visible = getDefinitionByName("com.robot.app2.control.DaanHeitianCountermarkController").showidx.indexOf(_loc1_) != -1;
            _loc1_++;
         }
      }
      
      private function removeallBox() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            btnLevel["box_" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            btnLevel["box_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.clickHandle);
            _loc1_++;
         }
         SystemTimerManager.removeTickFun(this.timerHandle);
         super.destroy();
      }
   }
}

