package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SOManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.ArrayUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.SharedObject;
   import flash.utils.ByteArray;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_1202 extends BaseMapProcess
   {
      
      private var time:int;
      
      private var initd:Boolean = false;
      
      private var clicked:Boolean = false;
      
      private var pos:Array;
      
      private var _ui:MovieClip;
      
      private var broadcaseidx:int = -1;
      
      private var broadcasearr:Array = ["精灵训练营最后一周！精彩活动不容错过！","游戏城又有新的游戏啦！放松心情，不容错过！","参与实战训练，免费试用本周最新精灵，更有奖励可得！"];
      
      private var broadcasetime:int;
      
      public function MapProcess_1202()
      {
         super();
      }
      
      override protected function init() : void
      {
         var k:int;
         this.pos = [];
         k = 0;
         while(k < 5)
         {
            this.pos.push(new Point(btnLevel["box_" + k].x,btnLevel["box_" + k].y));
            k++;
         }
         SystemTimerManager.addTickFun(this.timerHandle);
         topLevel["mc"].visible = false;
         topLevel["mc1"].visible = false;
         KTool.getBitSet([15119],function(param1:Array):void
         {
            var _loc2_:int = 0;
            while(_loc2_ < 5)
            {
               btnLevel["box_" + _loc2_].addEventListener(MouseEvent.CLICK,clickHandle);
               btnLevel["box_" + _loc2_].visible = false;
               _loc2_++;
            }
            var _loc3_:int = 0;
            while(_loc3_ < 7)
            {
               btnLevel["go_" + _loc3_].addEventListener(MouseEvent.CLICK,goappHandle);
               _loc3_++;
            }
         });
      }
      
      public function loadUI() : void
      {
         ResourceManager.getResource(ClientConfig.getAppResource("2016/0812/trainbroadcast"),function(param1:MovieClip):void
         {
            if(topLevel)
            {
               _ui = param1;
               LevelManager.mapLevel.addChild(_ui);
               broadcaseidx = 0;
            }
         });
      }
      
      private function goappHandle(param1:MouseEvent) : void
      {
         if(this.clicked)
         {
            return;
         }
         var _loc2_:Array = ["HolidayvillagePanel","SummerGameCity0729Panel","NormalNoticePanel","TimedNoticePanel","ArenaPanel","SummerCampExchangePanel","SummerCamp2018MainPanel"];
         var _loc3_:int = int(param1.currentTarget.name.split("_")[1]);
         ModuleManager.showAppModule(_loc2_[_loc3_]);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var idx:int;
         var e:MouseEvent = param1;
         if(this.clicked)
         {
            return;
         }
         idx = int(e.currentTarget.name.split("_")[1]);
         SocketConnection.sendByQueue(45674,[26,9]);
         btnLevel["box_" + idx].visible = false;
         SocketConnection.sendByQueue(41254,[idx < 2 ? 28 : 29],function(param1:SocketEvent):void
         {
            timerHandle();
            var _loc2_:ByteArray = param1.data as ByteArray;
            _loc2_.readUnsignedInt();
            var _loc3_:int = int(_loc2_.readUnsignedInt());
            if(_loc3_ == 25)
            {
               Alarm.show("很遗憾，你慢了一步，宝箱被别人捡走了！");
            }
         },function(param1:*):void
         {
         });
      }
      
      protected function timerHandle() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SharedObject = null;
         var _loc5_:Date = null;
         var _loc6_:String = null;
         var _loc1_:Date = SystemTimerManager.sysBJDate;
         if(_loc1_.hours == 18 && (_loc1_.minutes >= 0 && _loc1_.minutes < 30))
         {
            topLevel["mc1"].visible = true;
            _loc2_ = _loc1_.minutes * 60 + _loc1_.seconds;
            topLevel["mc1"]["stxt"].text = "今日已送出" + int((int(_loc2_ / 30) + 1) / 2) + "/" + 30 + "波好礼";
            _loc3_ = _loc1_.seconds;
            if(_loc3_ >= 30)
            {
               if(_loc1_.minutes >= 29)
               {
                  topLevel["mc"].visible = false;
               }
               else
               {
                  topLevel["mc"].visible = true;
                  KTool.showScore(topLevel["mc"]["sec"],60 - _loc3_ + 30);
               }
               if(!this.initd)
               {
                  this.showbox();
               }
            }
            else
            {
               this.initd = false;
               topLevel["mc"].visible = true;
               KTool.showScore(topLevel["mc"]["sec"],30 - _loc3_);
               this.removeallBox();
            }
         }
         else
         {
            this.initd = false;
            topLevel["mc1"].visible = false;
            topLevel["mc"].visible = false;
            this.removeallBox();
         }
         if(this.broadcaseidx != -1)
         {
            if(this._ui)
            {
               this._ui["txt"].text = this.broadcasearr[this.broadcaseidx];
            }
            if(this.broadcasetime++)
            {
               if(this.broadcasetime >= 10)
               {
                  this.broadcasetime = 0;
                  ++this.broadcaseidx;
                  if(this.broadcaseidx >= this.broadcasearr.length)
                  {
                     if(this._ui)
                     {
                        if(this._ui.parent)
                        {
                           this._ui.parent.removeChild(this._ui);
                        }
                        this._ui = null;
                     }
                     _loc4_ = _loc4_ = SOManager.getUserSO(SOManager.ACTIVITY);
                     _loc5_ = SystemTimerManager.sysBJDate;
                     _loc6_ = (_loc5_.time / 1000 - _loc5_.minutes * 60 - _loc5_.hours * 3600 - _loc5_.seconds - _loc5_.day * 24 * 3600).toString();
                     _loc4_.data["trainbroadcast_" + _loc6_] = true;
                     this.broadcaseidx = -1;
                  }
                  else if(this._ui)
                  {
                     this._ui["txt"].text = this.broadcasearr[this.broadcaseidx];
                  }
               }
            }
         }
      }
      
      private function showbox() : void
      {
         var k:int;
         var now:Date = null;
         this.pos = ArrayUtils.shuffle(this.pos);
         k = 0;
         while(k < 5)
         {
            btnLevel["box_" + k].x = this.pos[k].x;
            btnLevel["box_" + k].y = this.pos[k].y;
            k++;
         }
         this.initd = true;
         now = SystemTimerManager.sysBJDate;
         KTool.getMultiValue([13910,13911,13912],function(param1:Array):void
         {
            var _loc2_:int = now.minutes == param1[0] ? int(2 - param1[1]) : 2;
            var _loc3_:int = now.minutes == param1[0] ? int(3 - param1[2]) : 3;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            while(_loc5_ < 2)
            {
               btnLevel["box_" + _loc5_].visible = _loc4_ < _loc2_;
               _loc4_++;
               _loc5_++;
            }
            _loc4_ = 0;
            _loc5_ = 2;
            while(_loc5_ < 5)
            {
               btnLevel["box_" + _loc5_].visible = _loc4_ < _loc3_;
               _loc4_++;
               _loc5_++;
            }
         });
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
         var _loc2_:int = 0;
         while(_loc2_ < 7)
         {
            btnLevel["go_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.goappHandle);
            _loc2_++;
         }
         SystemTimerManager.removeTickFun(this.timerHandle);
         if(this._ui)
         {
            if(this._ui.parent)
            {
               this._ui.parent.removeChild(this._ui);
            }
            this._ui = null;
         }
         super.destroy();
      }
   }
}

