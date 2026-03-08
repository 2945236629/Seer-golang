package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.active.HallowmasControllerFor788;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   
   public class MapProcess_788 extends BaseMapProcess
   {
      
      private var panel:MovieClip;
      
      public function MapProcess_788()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86053244);
         SocketConnection.send(1022,86053246);
         HallowmasControllerFor788.init(this);
         this.initPumpkins();
         MapListenerManager.add(conLevel["hand"],function():void
         {
            if(conLevel["hand"].currentFrame == 1)
            {
               AnimateManager.playMcAnimate(conLevel["hand"],1,null,function():void
               {
                  MapListenerManager.add(conLevel["toBatCave"],function():void
                  {
                     if(!panel)
                     {
                        panel = MapManager.currentMap.libManager.getMovieClip("infoPanel");
                        MapListenerManager.add(panel["goMapBtn"],function():void
                        {
                           SocketConnection.send(1022,86051701);
                           var _loc1_:Date = SystemTimerManager.sysDate;
                           if(_loc1_.hours == 13 || _loc1_.hours == 14)
                           {
                              MapManager.changeMap(792);
                           }
                           else
                           {
                              Alarm.show("现在不在活动时间噢，13：00--15：00再来吧！");
                           }
                        });
                        MapListenerManager.add(panel["close"],function():void
                        {
                           if(panel.parent)
                           {
                              panel.parent.removeChild(panel);
                           }
                        });
                     }
                     topLevel.addChild(panel);
                  },"蝙蝠洞");
               });
            }
         },"不要点我噢！");
      }
      
      private function initPumpkins() : void
      {
      }
      
      override public function destroy() : void
      {
         this.panel = null;
      }
   }
}

