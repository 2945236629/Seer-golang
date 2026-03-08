package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.components.ShowMultiBuyPanelComponent;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.DataEvent;
   import flash.events.MouseEvent;
   import org.taomee.events.SocketEvent;
   
   public class MapProcess_11286 extends BaseMapProcess
   {
      
      private var _itemNumArr:Array;
      
      private var _fightNum:int;
      
      private var _timeArr:Array;
      
      private var _map:BaseMapProcess;
      
      private var _multyCom2:ShowMultiBuyPanelComponent;
      
      private var _multyCom:ShowMultiBuyPanelComponent;
      
      public function MapProcess_11286()
      {
         super();
      }
      
      override public function destroy() : void
      {
         this._timeArr.length = 0;
         this._timeArr = null;
         this._map.depthLevel.removeEventListener(MouseEvent.CLICK,this.onClickDepthHandle);
         this._map.btnLevel.removeEventListener(MouseEvent.CLICK,this.onClickBtnHandle);
         this._map.topLevel.removeEventListener(MouseEvent.CLICK,this.onClickTopHandle);
         SystemTimerManager.removeTickFun(this.onTick);
         this._map = null;
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         this._multyCom.destroy();
         this._multyCom = null;
         this._multyCom2.destroy();
         this._multyCom2 = null;
         super.destroy();
      }
      
      override protected function init() : void
      {
         StatManager.sendStat2014("0722吃瓜爽酷暑","进入种瓜场景","2016运营活动");
         this._map = this;
         this._timeArr = [];
         this.updataState();
         this._map.topLevel.visible = false;
         this._map.depthLevel.addEventListener(MouseEvent.CLICK,this.onClickDepthHandle);
         this._map.btnLevel.addEventListener(MouseEvent.CLICK,this.onClickBtnHandle);
         this._map.topLevel.addEventListener(MouseEvent.CLICK,this.onClickTopHandle);
         SystemTimerManager.addTickFun(this.onTick);
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         this._multyCom = new ShowMultiBuyPanelComponent(this._map.btnLevel["buyBtn_0"],{
            "productID":248166,
            "iconID":1710160,
            "exchangeID":9158
         },this.updataState);
         this._multyCom2 = new ShowMultiBuyPanelComponent(this._map.btnLevel["buyBtn_1"],{
            "productID":248167,
            "iconID":1710161,
            "exchangeID":9159
         },this.updataState);
      }
      
      private function onClickDepthHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         if(param1.target is MovieClip && param1.target.currentFrame == 2 || _loc2_.indexOf("_") == -1)
         {
            return;
         }
         var _loc3_:MovieClip = param1.target as MovieClip;
         if(_loc2_ == "watermelon_btn")
         {
            _loc2_ = param1.target.parent.name;
            _loc3_ = param1.target.parent;
         }
         var _loc4_:int = int(_loc2_.replace("watermelonMc_",""));
         if(_loc3_.currentFrame == 1)
         {
            if(this._itemNumArr[6] > 0)
            {
               this.sendComd(46221,[5,_loc4_ + 1],this.updataState);
            }
            else
            {
               Alarm.show("你的西瓜种子数量不足，先找橡木蝶获得种子吧！");
            }
         }
         else if(_loc3_.currentFrame > 2)
         {
            this.sendComd(46221,[7,_loc4_ + 1],this.updataState);
         }
      }
      
      private function onClickBtnHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var str:String = e.target.name;
         switch(str)
         {
            case "leftBtn":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("GrowWatermelonsForSunmerMainPanel");
               });
               break;
            case "exchangeBtn":
               ModuleManager.showAppModule("GrowWatermelonsForSunmerExchangePanel");
               ModuleManager.addEventListener(ModuleManager.MODEL_CLOSE,function(param1:DataEvent):void
               {
                  ModuleManager.removeListener(ModuleManager.MODEL_CLOSE,arguments.callee);
                  updataState();
               });
               break;
            case "blackBtn":
               if(e.target.parent.currentFrame == 1)
               {
                  this._map.topLevel["mc"].gotoAndStop(1);
                  this._map.topLevel.visible = true;
                  break;
               }
               if(e.target.parent.currentFrame == 3)
               {
                  this._map.topLevel["mc"].gotoAndStop(2);
                  this._map.topLevel.visible = true;
               }
               break;
            case "xmudieBtn":
               this._map.topLevel["mc"].gotoAndStop(3);
               this._map.topLevel["mc"]["fightNumTxt"].text = this._fightNum + "";
               this._map.topLevel.visible = true;
               break;
            default:
               this.openBag(str);
         }
      }
      
      private function onClickTopHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "btnClose":
               this._map.topLevel.visible = false;
               break;
            case "startBtn":
               if(this._itemNumArr[0] >= 3)
               {
                  this.sendComd(46221,[1,0],this.updataState);
                  this._map.topLevel.visible = false;
                  break;
               }
               Alarm.show("你的小西瓜数量不足三个，先去种西瓜吧！");
               break;
            case "getBtn":
               this.sendComd(46221,[3,0],this.updataState);
               this._map.topLevel["mc"].gotoAndStop(1);
               break;
            case "fightBtn":
               this._map.topLevel.visible = false;
               FightManager.fightNoMapBoss("橡木蝶",7515);
               break;
            default:
               this.openBag(_loc2_);
         }
      }
      
      private function onTick() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         if(this._timeArr.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this._timeArr.length)
            {
               _loc1_ = this._timeArr[_loc2_];
               --_loc1_.time;
               if(_loc1_.index < 6)
               {
                  this._map.depthLevel["watermelonMc_" + _loc1_.index]["timeTxt"].text = this.getTimeStr(_loc1_.time);
               }
               else
               {
                  this._map.btnLevel["blackMc"]["timeTxt"].text = this.getTimeStr(_loc1_.time);
               }
               if(_loc1_.time < 1)
               {
                  this._timeArr.splice(_loc2_,1);
                  if(_loc1_.index < 6)
                  {
                     this.sendComd(46221,[6,_loc1_.index + 1],this.updataState);
                  }
                  else
                  {
                     this.sendComd(46221,[2,0],this.updataState);
                  }
               }
               _loc2_++;
            }
         }
      }
      
      private function getTimeStr(param1:uint) : String
      {
         var _loc2_:int = param1 % 60;
         var _loc3_:int = param1 % 3600 / 60;
         var _loc4_:String = "";
         _loc4_ = _loc2_ < 10 ? "0" + _loc2_ : _loc2_ + "";
         return (_loc3_ < 10 ? "0" + _loc3_ : _loc3_ + "") + ":" + _loc4_;
      }
      
      private function updataState() : void
      {
         KTool.getMultiValue([4320,4321,4322,4323,4324,4325,4326,4327,4328,14212],function(param1:Array):void
         {
            var j:int;
            var k:int = 0;
            var obj:Object = null;
            var a:Array = param1;
            var timeArr:Array = [120,180,180,300,300,600];
            var u:uint = uint(a[7]);
            _timeArr.length = 0;
            j = 0;
            while(j < 6)
            {
               if(j >= 4 && u != a[8])
               {
                  u = uint(a[8]);
               }
               if(j < 4)
               {
                  k = int(KTool.getByte(u,j));
               }
               else
               {
                  k = int(KTool.getByte(u,j - 4));
               }
               _map.depthLevel["watermelonMc_" + j].gotoAndStop(k);
               _map.depthLevel["watermelonMc_" + j].mouseChildren = false;
               if(k == 2)
               {
                  _map.depthLevel["watermelonMc_" + j].buttonMode = false;
                  if(SystemTimerManager.time - a[j] >= timeArr[j])
                  {
                     sendComd(46221,[6,j + 1],updataState);
                     return;
                  }
                  obj = new Object();
                  obj.time = timeArr[j] - SystemTimerManager.time + a[j];
                  obj.index = j;
                  _timeArr.push(obj);
               }
               else if(k == 0 || k == 1)
               {
                  _map.depthLevel["watermelonMc_" + j].mouseChildren = true;
               }
               else
               {
                  _map.depthLevel["watermelonMc_" + j].buttonMode = true;
               }
               j++;
            }
            k = int(KTool.getByte(u,2));
            _map.btnLevel["blackMc"].gotoAndStop(k);
            if(k == 2)
            {
               if(SystemTimerManager.time - a[j] >= 900)
               {
                  sendComd(46221,[2,0],updataState);
               }
               else
               {
                  obj = new Object();
                  obj.time = 900 - SystemTimerManager.time + a[j];
                  obj.index = j;
                  _timeArr.push(obj);
               }
            }
            _fightNum = a[9];
            ItemManager.updateAndGetItemsNum([1710155,1710156,1710157,1710158,1710159,1710160,1710161],function(param1:Array):void
            {
               _itemNumArr = param1;
               var _loc2_:int = 0;
               while(_loc2_ < param1.length)
               {
                  _map.btnLevel["numTxt_" + _loc2_].text = param1[_loc2_] + "";
                  _loc2_++;
               }
            });
         });
      }
      
      private function openBag(param1:String) : void
      {
         if(param1 == "bagBtn")
         {
            PetBagControllerNew.showByBuffer();
         }
         else if(param1 == "cureBtn")
         {
            PetManager.cureAll();
         }
      }
      
      private function sendComd(param1:int, param2:Array, param3:Function) : void
      {
         var cmd:int = param1;
         var args:Array = param2;
         var callback:Function = param3;
         SocketConnection.sendByQueue(cmd,args,function(param1:SocketEvent):void
         {
            if(callback != null)
            {
               callback();
            }
         });
      }
   }
}

