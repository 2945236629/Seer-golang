package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MapProcess_11594 extends BaseMapProcess
   {
      
      private var time1:uint;
      
      private var time2:uint;
      
      private var hasCollect:int = 0;
      
      private var leftTimeArr:Array = [0,0,0,0];
      
      public function MapProcess_11594()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.updateMap();
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         btnLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      override public function destroy() : void
      {
         clearTimeout(this.time1);
         clearTimeout(this.time2);
         btnLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         super.destroy();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var mc:MovieClip = null;
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "good":
               StatManager.sendStat2014("0105灵兽宫的祝福","点击场景中的灵兽能量","2018运营活动");
               mc = e.target.parent as MovieClip;
               MainManager.actorModel.moveAndAction(new Point(mc.x,mc.y + mc.height),function():void
               {
                  var index:int = 0;
                  index = int(e.target.parent.name.split("_")[1]);
                  if(hasCollect < 8)
                  {
                     mc.gotoAndStop(2);
                     clearTimeout(time1);
                     clearTimeout(time2);
                     mc.addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
                     {
                        var e:Event = param1;
                        mc.removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
                        mc["mc"].gotoAndStop(1);
                        btnLevel.mouseChildren = btnLevel.mouseEnabled = false;
                        AnimateManager.playMcAnimate(mc,2,"mc",function():void
                        {
                           SocketConnection.sendWithCallback(43279,function():void
                           {
                              btnLevel.mouseChildren = btnLevel.mouseEnabled = true;
                              mc.gotoAndStop(3);
                              updateMap();
                           },12,index);
                        });
                     });
                  }
                  else
                  {
                     Alarm.show("你已收集了全部的灵兽能量，请明天再来吧！");
                  }
               });
               break;
            case "exit":
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("LingShouGongMainPanel");
               });
         }
      }
      
      public function updateMap() : void
      {
         ItemManager.updateAndGetItemsNum([1715584],function(param1:Array):void
         {
            btnLevel["txt"].text = param1[0];
         });
         KTool.getMultiValue([15514,15515,15516,15517,15518],function(param1:Array):void
         {
            var _loc2_:int = 60;
            var _loc3_:int = 0;
            var _loc4_:int = 1;
            while(_loc4_ <= 4)
            {
               _loc3_ = param1[_loc4_ - 1] + 60 - SystemTimerManager.time;
               if(_loc3_ > 0)
               {
                  btnLevel["mc_" + _loc4_].gotoAndStop(3);
               }
               else
               {
                  btnLevel["mc_" + _loc4_].gotoAndStop(1);
               }
               leftTimeArr[_loc4_ - 1] = _loc3_;
               if(_loc3_ > 0 && _loc2_ > _loc3_)
               {
                  _loc2_ = _loc3_;
               }
               _loc4_++;
            }
            clearTimeout(time2);
            showLeftTime();
            clearTimeout(time1);
            if(_loc2_ > 0)
            {
               time1 = setTimeout(updateMap,_loc2_ * 1000);
            }
            hasCollect = param1[4];
         });
      }
      
      public function showLeftTime() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 1;
         while(_loc2_ <= 4)
         {
            _loc1_ = int(this.leftTimeArr[_loc2_ - 1]);
            if(_loc1_ > 0 && MovieClip(btnLevel["mc_" + _loc2_]).currentFrame == 3 && btnLevel["mc_" + _loc2_]["txt"] != null)
            {
               btnLevel["mc_" + _loc2_]["txt"].text = int(_loc1_ / 60) + ":" + (_loc1_ % 60 >= 10 ? "" : "0") + _loc1_ % 60;
               --this.leftTimeArr[_loc2_ - 1];
            }
            _loc2_++;
         }
         this.time2 = setTimeout(this.showLeftTime,1000);
      }
   }
}

