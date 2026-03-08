package com.robot.app.mapProcess
{
   import com.robot.core.config.xml.ZhanlianSkinTaskXmlInfo;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11898 extends BaseMapProcess
   {
      
      public function MapProcess_11898()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc5_:Number = NaN;
         (conLevel["npc"] as MovieClip).buttonMode = true;
         conLevel["npc"].addEventListener(MouseEvent.CLICK,this.clickHandle);
         var _loc1_:Array = ZhanlianSkinTaskXmlInfo.getVersions();
         var _loc2_:Number = Number(SystemTimerManager.sysBJDate.time);
         var _loc3_:int = 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Number(SystemTimerManager.get24DateByStr(_loc1_[_loc4_]).time);
            if(_loc2_ <= _loc5_)
            {
               break;
            }
            _loc3_++;
            _loc4_++;
         }
         conLevel["npc"].gotoAndStop(_loc3_);
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("ZhanlianSkinTaskMainPanel");
      }
      
      override public function destroy() : void
      {
         conLevel["npc"].removeEventListener(MouseEvent.CLICK,this.clickHandle);
      }
   }
}

