package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcess_11202 extends BaseMapProcess
   {
      
      public const CD:int = 10;
      
      private var _count:uint = 0;
      
      private var dt:Date;
      
      private var _baseTime:uint = 0;
      
      private var _nextTime:uint;
      
      private var _isWait:Boolean = true;
      
      private var _isDig:Boolean = false;
      
      private var _finishDigTime:Number;
      
      private var _digNum:uint;
      
      public function MapProcess_11202()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.dt = SystemTimerManager.sysBJDate;
         topLevel["proShow_0"].visible = false;
         topLevel["proShow_1"].visible = false;
         topLevel["proShow_2"].visible = false;
         topLevel["waitPanel"].visible = false;
         topLevel["timeTxt"].visible = false;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         topLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         topLevel.addEventListener(Event.ENTER_FRAME,this.onFrame);
         this.thisUpdate();
      }
      
      override public function destroy() : void
      {
         topLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
      }
      
      private function thisUpdate() : void
      {
         KTool.getMultiValue([4309,14206],function(param1:Array):void
         {
            var arr:Array = param1;
            _count = arr[0];
            if(_count >= 3)
            {
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("TwinsBrothersGivePanel");
               });
            }
            topLevel["countTxt"].text = _count + "/3";
            _nextTime = CD + arr[1];
            if(dt.time / 1000 < _nextTime)
            {
               _isWait = true;
               topLevel["waitPanel"].visible = true;
               topLevel["timeTxt"].visible = true;
            }
            else
            {
               _isWait = false;
               topLevel["waitPanel"].visible = false;
               topLevel["timeTxt"].visible = false;
            }
         });
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         var index:uint = uint(evt.target.name.split("_")[1]);
         var str:String = evt.target.name.split("_")[0];
         switch(str)
         {
            case "leave":
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("TwinsBrothersGivePanel");
               });
               break;
            case "oneKey":
               KTool.buyProductByCallback(247198,1,function():void
               {
                  KTool.doExchange(8696,function():void
                  {
                     KTool.changeMapWithCallBack(1,function():void
                     {
                        ModuleManager.showAppModule("TwinsBrothersGivePanel");
                     });
                  });
               });
               break;
            case "stone":
               if(this._isDig)
               {
                  Alarm.show("你已经有矿石在开采中，请耐心等待！");
                  break;
               }
               if(this.dt.time / 1000 >= this._nextTime)
               {
                  this.digStone(index);
                  break;
               }
               Alarm.show("请耐心等待一会儿再来采集矿石！");
         }
      }
      
      private function onFrame(param1:Event) : void
      {
         ++this._baseTime;
         if(this._baseTime % 12 == 0)
         {
            this.updateTime();
         }
      }
      
      private function updateTime() : void
      {
         var temp:uint = 0;
         var timeTemp:uint = 0;
         this.dt = SystemTimerManager.sysBJDate;
         if(this._isWait)
         {
            if(this.dt.time / 1000 > this._nextTime)
            {
               topLevel["waitPanel"].visible = false;
               topLevel["timeTxt"].visible = false;
               this._isWait = false;
            }
            else
            {
               temp = this._nextTime - this.dt.time / 1000;
               topLevel["timeTxt"].text = temp;
            }
         }
         if(this._isDig)
         {
            if(this.dt.time < this._finishDigTime)
            {
               timeTemp = 5000 - (this._finishDigTime - this.dt.time);
               topLevel["proShow_" + this._digNum]["process"].gotoAndStop(int(timeTemp / 50));
               topLevel["proShow_" + this._digNum]["proTxt"].text = uint(timeTemp / 1000) + "/5";
            }
            else
            {
               topLevel["proShow_" + this._digNum].visible = false;
               this._isDig = false;
               SocketConnection.sendByQueue(46216,[3,0],function():void
               {
                  thisUpdate();
               });
            }
         }
      }
      
      private function digStone(param1:uint) : void
      {
         this._isDig = true;
         this._digNum = param1;
         topLevel["proShow_" + this._digNum].visible = true;
         topLevel["proShow_" + this._digNum]["process"].gotoAndStop(1);
         topLevel["proShow_" + this._digNum]["proTxt"].text = "0/5";
         this._finishDigTime = this.dt.time + 5000;
      }
   }
}

