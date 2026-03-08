package com.robot.app.mapProcess
{
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import flash.display.MovieClip;
   import org.taomee.utils.*;
   
   public class MapProcess_677 extends BaseMapProcess
   {
      
      public function MapProcess_677()
      {
         super();
      }
      
      override protected function init() : void
      {
         var m:MovieClip = null;
         var t:uint = 0;
         conLevel["arrow"].visible = false;
         conLevel["task746"].visible = false;
         m = conLevel["finalBoss"];
         m.mouseChildren = true;
         m.buttonMode = true;
         if(Boolean(1))
         {
            MapListenerManager.add(m,function():void
            {
               SocketConnection.send(1022,86053857);
               ModuleManager.showModule(ClientConfig.getAppModule("YiNengBossPanel"),"正在打开异能王的六重试炼....");
            },"终极挑战");
         }
         else
         {
            DisplayUtil.removeForParent(m);
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}

