package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.mapProcess.control.activityControl.ActivityControl;
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
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_1567 extends BaseMapProcess
   {
      
      private var tip:SimpleButton;
      
      private var _ogre:OgreModel;
      
      private var _activitycontroller:ActivityControl;
      
      private var showed:Boolean = false;
      
      public function MapProcess_1567()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.tip = conLevel["tip"];
         this.tip.addEventListener(MouseEvent.CLICK,this.ontipClick);
         SystemTimerManager.addTickFun(this.timerHandle);
         MapManager.addEventListener(MapEvent.MAP_MOUSE_DOWN,this.onMapDown);
         var _loc1_:Array = [];
         var _loc2_:CronTimeVo = new CronTimeVo("*","19-20","*","*","*","*");
         _loc1_.push(_loc2_);
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
         var _loc2_:int = 0;
         if(this.intime())
         {
            if(!this._ogre)
            {
               _loc1_ = OgreXMLInfo.getOgreList(1567).concat();
               this._ogre = new OgreModel(100001);
               _loc2_ = Math.random() * _loc1_.length;
               this._ogre.show(4409,_loc1_[_loc2_]);
               this._ogre.addEventListener(MouseEvent.CLICK,this.clickHandle);
            }
         }
         else if(this._ogre)
         {
            this._ogre.destroy();
            this._ogre = null;
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
               PetFightModel.defaultNpcID = 4409;
               FightManager.fightWithBoss(PetXMLInfo.getName(4409),0);
            }
         }
      }
      
      public function intime() : Boolean
      {
         return this._activitycontroller.isInActivityTime;
      }
      
      private function ontipClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("Map1567TipPanel");
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

