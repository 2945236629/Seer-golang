package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.xml.ServerMapsXMLInfo;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11899 extends BaseMapProcess
   {
      
      private var times:Array = [8,10,12,14,16,18,20];
      
      private var refreshTime:int;
      
      private var showalarm:Boolean;
      
      public function MapProcess_11899()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         StatManager.sendStat2014("0122春节全民大战","进入地图1","2020运营活动");
         conLevel["mc"].gotoAndStop(1);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            conLevel["pro_" + _loc1_].gotoAndStop(1);
            (conLevel["pro_" + _loc1_] as MovieClip).buttonMode = true;
            conLevel["txt_" + _loc1_].text = 0;
            conLevel["pro_" + _loc1_].addEventListener(MouseEvent.CLICK,this.bclickHandle);
            _loc1_++;
         }
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         this.refreshTime = 0;
         SystemTimerManager.addTickFun(this.timerHandle);
         this.update();
      }
      
      private function update() : void
      {
         var time:Date;
         var hour:int;
         var i:int;
         var index:int = 0;
         var killnum:int = 0;
         if(this.showalarm)
         {
            return;
         }
         time = SystemTimerManager.sysBJDate;
         hour = time.hours;
         i = 0;
         while(i < this.times.length)
         {
            if(hour < this.times[i])
            {
               break;
            }
            index++;
            i++;
         }
         KTool.getGlobalSubkeyValues(10029,[index * 10 + 1,index * 10 + 2,index * 10 + 3,index * 10 + 4,index * 10 + 5,index * 10 + 6],function(param1:Array):void
         {
            var j:int = 0;
            var pro:int = 0;
            var arr:Array = param1;
            if(Boolean(conLevel) && Boolean(conLevel["mc"]))
            {
               j = 0;
               while(j < arr.length)
               {
                  killnum += arr[j];
                  if(j < 4)
                  {
                     conLevel["txt_" + j].text = 100000 - arr[j];
                     conLevel["pro_" + j].gotoAndStop(int(conLevel["pro_" + j].totalFrames * Number((100000 - arr[j]) / 100000)) + 1);
                     CommonUI.setEnabled(conLevel["pro_" + j],arr[j] < 100000);
                  }
                  j++;
               }
               if(killnum >= 600000)
               {
                  showalarm = true;
                  Alarm.show("试炼秘境已经没有野怪了，是时候离开啦！",function():void
                  {
                     var _loc1_:int = int(ServerMapsXMLInfo.getLoginMapId(2));
                     MapManager.changeMap(_loc1_);
                  });
               }
               else if(killnum >= 200000)
               {
                  conLevel["mc"].gotoAndStop(2);
               }
               else
               {
                  conLevel["mc"].gotoAndStop(1);
                  pro = Number(killnum / 200000) * 100;
                  if(pro > 100)
                  {
                     pro = 100;
                  }
                  conLevel["mc"]["txt"].text = pro + "%";
                  conLevel["mc"]["pro"].gotoAndStop(int(conLevel["mc"]["pro"].totalFrames * Number(pro / 100)) + 1);
               }
            }
         });
      }
      
      private function timerHandle() : void
      {
         this.check();
         ++this.refreshTime;
         if(this.refreshTime >= 300)
         {
            this.refreshTime = 0;
            this.update();
         }
      }
      
      private function check() : void
      {
         var time:Date = SystemTimerManager.sysBJDate;
         if(time.hours < 8 || time.hours >= 22)
         {
            this.showalarm = true;
            Alarm.show("试炼已关闭，是时候离开啦！",function():void
            {
               var _loc1_:int = int(ServerMapsXMLInfo.getLoginMapId(2));
               MapManager.changeMap(_loc1_);
            });
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "go":
               MapManager.changeMap(11900);
               break;
            case "tipBtn":
               ModuleManager.showAppModule("SpringFesBattle2020S1Panel");
         }
      }
      
      private function bclickHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var ename:String = e.currentTarget.name;
         var index:int = int(ename.split("_")[1]);
         SocketConnection.sendByQueue(42383,[34,index + 1],function(param1:*):void
         {
            StatManager.sendStat2014("0122春节全民大战","地图1与野怪进入战斗","2020运营活动");
         },function(param1:*):void
         {
            update();
         });
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            conLevel["pro_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.bclickHandle);
            _loc1_++;
         }
         SystemTimerManager.removeTickFun(this.timerHandle);
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
      }
   }
}

