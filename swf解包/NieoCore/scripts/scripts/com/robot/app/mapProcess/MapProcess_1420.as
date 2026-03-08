package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_1420 extends BaseMapProcess
   {
      
      private var ogre:OgreModel;
      
      public function MapProcess_1420()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel.addEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.addTickFun(this.timerHandle);
         this.timerHandle();
      }
      
      private function timerHandle() : void
      {
         this.check();
      }
      
      private function check() : void
      {
         var _loc1_:Date = SystemTimerManager.sysBJDate;
         if(_loc1_.hours == 19 && (_loc1_.minutes >= 10 && _loc1_.minutes < 15 || _loc1_.minutes >= 45 && _loc1_.minutes < 50) || _loc1_.hours == 20 && (_loc1_.minutes >= 15 && _loc1_.minutes < 20 || _loc1_.minutes >= 50 && _loc1_.minutes < 55))
         {
            this.showogre();
         }
         else
         {
            this.hideOgre();
         }
      }
      
      private function showogre() : void
      {
         if(this.ogre != null)
         {
            return;
         }
         this.ogre = new OgreModel(0);
         this.ogre.show(4006,new Point(380,480));
         this.ogre.addEventListener(MouseEvent.CLICK,this.ogreClickHandle);
      }
      
      private function ogreClickHandle(param1:MouseEvent) : void
      {
         SocketConnection.sendByQueue(2411,[0,0]);
      }
      
      private function hideOgre() : void
      {
         if(this.ogre)
         {
            if(this.ogre.parent)
            {
               this.ogre.parent.removeChild(this.ogre);
            }
            this.ogre.removeEventListener(MouseEvent.CLICK,this.ogreClickHandle);
            this.ogre.destroy();
            this.ogre = null;
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "tip":
               ModuleManager.showAppModule("GeduoTipPanel");
         }
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.removeTickFun(this.timerHandle);
         this.hideOgre();
      }
   }
}

