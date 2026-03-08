package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.mapProcess.control.activityControl.ActivityControl;
   import com.robot.app.ogre.OgreController;
   import com.robot.core.config.xml.OgreXMLInfo;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.utils.CronTimeVo;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_1293 extends BaseMapProcess
   {
      
      private var tip:MovieClip;
      
      private var _ogre:OgreModel;
      
      private var _activitycontroller:ActivityControl;
      
      private var showed:Boolean = false;
      
      public function MapProcess_1293()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.tip = btnLevel["tip"];
         this.tip.buttonMode = true;
         this.tip.addEventListener(MouseEvent.CLICK,this.ontipClick);
         SystemTimerManager.addTickFun(this.timerHandle);
         MapManager.addEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapDown);
         var _loc1_:Array = [];
         var _loc2_:CronTimeVo = new CronTimeVo("15-17","19","*","*","*","*");
         var _loc3_:CronTimeVo = new CronTimeVo("2-4","20","*","*","*","*");
         var _loc4_:CronTimeVo = new CronTimeVo("58-59","20","*","*","*","*");
         var _loc5_:CronTimeVo = new CronTimeVo("0","21","*","*","*","*");
         var _loc6_:CronTimeVo = new CronTimeVo("39-41","21","*","*","*","*");
         _loc1_.push(_loc2_);
         _loc1_.push(_loc3_);
         _loc1_.push(_loc4_);
         _loc1_.push(_loc5_);
         _loc1_.push(_loc6_);
         this._activitycontroller = new ActivityControl(_loc1_);
         this.timerHandle();
      }
      
      private function onMapDown(param1:MapEvent) : void
      {
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onEnter);
      }
      
      private function timerHandle() : void
      {
         var _loc1_:Array = null;
         if(this.intime())
         {
            OgreController.isShow = false;
            if(!this._ogre)
            {
               _loc1_ = OgreXMLInfo.getOgreList(1293).concat();
               OgreModel.isShow = true;
               this._ogre = new OgreModel(100001);
               this._ogre.show(3628,_loc1_[0]);
               this._ogre.addEventListener(MouseEvent.CLICK,this.clickHandle);
            }
         }
         else
         {
            OgreController.isShow = false;
            if(this._ogre)
            {
               this._ogre.destroy();
               this._ogre = null;
            }
         }
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         MainManager.actorModel.walkAction(this._ogre.pos);
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onEnter);
      }
      
      private function onEnter(param1:RobotEvent) : void
      {
         if(this._ogre != null)
         {
            if(Point.distance(MainManager.actorModel.pos,this._ogre.pos) < 20)
            {
               PetFightModel.defaultNpcID = 3628;
               FightManager.fightWithBoss(PetXMLInfo.getName(3628),0);
            }
         }
      }
      
      public function intime() : Boolean
      {
         return this._activitycontroller.isInActivityTime;
      }
      
      private function ontipClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("Map1293TipPanel");
      }
      
      override public function destroy() : void
      {
         SystemTimerManager.removeTickFun(this.timerHandle);
         this.tip.removeEventListener(MouseEvent.CLICK,this.ontipClick);
         MapManager.removeEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapDown);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onEnter);
         if(this._ogre)
         {
            this._ogre.removeEventListener(MouseEvent.CLICK,this.clickHandle);
            this._ogre.destroy();
            this._ogre = null;
         }
         this._activitycontroller = null;
         this.tip = null;
      }
   }
}

