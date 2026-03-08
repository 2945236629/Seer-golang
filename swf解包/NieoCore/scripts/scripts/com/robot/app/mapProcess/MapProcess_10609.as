package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.utils.BitUtils;
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_10609 extends BaseMapProcess
   {
      
      public function MapProcess_10609()
      {
         super();
      }
      
      override protected function init() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            MovieClip(btnLevel["pet_" + _loc1_]).buttonMode = true;
            MovieClip(btnLevel["pet_" + _loc1_]).addEventListener(MouseEvent.CLICK,this.onClickPet);
            _loc1_++;
         }
         this.updateArrow();
         EventManager.addEventListener("ShuraPlutoupdateArrow",this.updateArrow);
         StatManager.sendStat2014("冥帝修罗","成功进入10609号场景",StatManager.RUN_ACT);
      }
      
      private function updateArrow(param1:Event = null) : void
      {
         var e:Event = param1;
         KTool.getMultiValue([988],function(param1:Array):void
         {
            var _loc3_:Array = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            CommonUI.removeYellowArrow(LevelManager.appLevel);
            var _loc2_:int = int(param1[0]);
            if(_loc2_ < 15)
            {
               _loc3_ = [[274,172],[617,216],[384,227],[509,270]];
               _loc4_ = 0;
               while(_loc4_ < 4)
               {
                  _loc5_ = int(BitUtils.getBit(_loc2_,_loc4_));
                  if(_loc5_ == 0)
                  {
                     CommonUI.addYellowArrow(LevelManager.appLevel,_loc3_[_loc4_][0],_loc3_[_loc4_][1],320);
                     break;
                  }
                  _loc4_++;
               }
            }
         });
      }
      
      protected function onClickPet(param1:MouseEvent) : void
      {
         var petName:String = null;
         var event:MouseEvent = param1;
         petName = event.currentTarget.name;
         KTool.getMultiValue([988],function(param1:Array):void
         {
            var _loc2_:int = int(param1[0]);
            var _loc3_:int = int(petName.split("_")[1]);
            if(_loc2_ >= 15)
            {
               ModuleManager.showModule(ClientConfig.getAppModule("CrusadeShuraPlutoPanel"),"正在打开");
            }
            else
            {
               ModuleManager.showModule(ClientConfig.getAppModule("RescueShuraPlutoPanel"),"正在打开",_loc3_);
            }
         });
      }
      
      override public function destroy() : void
      {
         MovieClip(btnLevel["pet_1"]).removeEventListener(MouseEvent.CLICK,this.onClickPet);
         MovieClip(btnLevel["pet_2"]).removeEventListener(MouseEvent.CLICK,this.onClickPet);
         MovieClip(btnLevel["pet_3"]).removeEventListener(MouseEvent.CLICK,this.onClickPet);
         MovieClip(btnLevel["pet_4"]).removeEventListener(MouseEvent.CLICK,this.onClickPet);
         EventManager.removeEventListener("ShuraPlutoupdateArrow",this.updateArrow);
         CommonUI.removeYellowArrow(LevelManager.appLevel);
         super.destroy();
      }
   }
}

