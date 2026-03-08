package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_11026 extends BaseMapProcess
   {
      
      private var _monsterSpeed:int = 3;
      
      private var _monster0:Monster;
      
      private var _monster1:Monster;
      
      private var _monster2:Monster;
      
      private var _gotCount:int;
      
      private var defaultSpeed:int;
      
      private var defaultPoint:Point = new Point(510,550);
      
      private var _monsters:Array = [{
         "start":280,
         "end":190,
         "dir":1,
         "bossId":5855
      },{
         "start":800,
         "end":585,
         "dir":-1,
         "bossId":5854
      },{
         "start":312,
         "end":110,
         "dir":1,
         "bossId":5853
      }];
      
      private var staticClazz:*;
      
      public function MapProcess_11026()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         this.staticClazz = getDefinitionByName("com.robot.app2.control.StaticObjectControll");
         this.conLevel["starting"].mouseChildren = this.conLevel["starting"].mouseEnabled = false;
         if(this.staticClazz.getObjectByKey("speed") != null)
         {
            this.defaultSpeed = this.staticClazz.getObjectByKey("speed");
         }
         else
         {
            this.staticClazz.setObjectByKey("speed",MainManager.actorModel.speed);
            this.defaultSpeed = MainManager.actorModel.speed;
         }
         if(this.staticClazz.getObjectByKey("fightOver") != null)
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               _gotCount = staticClazz.getObjectByKey("gotCount");
               if((param1.dataObj as FightOverInfo).winnerID != MainManager.actorID)
               {
                  Alarm.show("很遗憾，你被守护者击败了！你得重新寻找明珠！");
                  _gotCount = 0;
                  staticClazz.setObjectByKey("gotCount",_gotCount);
                  MainManager.actorModel.pos = defaultPoint;
                  staticClazz.setObjectByKey("fightOver","over");
               }
               begin();
               staticClazz.setObjectByKey("isFighting",false);
            });
         }
         else
         {
            this._gotCount = 0;
            this.reset(true);
         }
         if(this.staticClazz.getObjectByKey("actorPos") == null)
         {
            this.staticClazz.setObjectByKey("actorPos",MainManager.actorModel.pos);
         }
         if(this.staticClazz.getObjectByKey("gotCount") == null)
         {
            this.staticClazz.setObjectByKey("gotCount",this._gotCount);
         }
         this.addEvents();
         super.init();
      }
      
      private function addEvents() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.conLevel["item_" + _loc1_].addEventListener(MouseEvent.CLICK,this.onClickItem);
            _loc1_++;
         }
         this.topLevel["panel"].addEventListener(MouseEvent.CLICK,this.onClickPanel);
         this.conLevel["exitBtn"].addEventListener(MouseEvent.CLICK,this.exit);
      }
      
      private function onClickPanel(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target.name;
         switch(_loc2_)
         {
            case "beginBtn":
               StatManager.sendStat2014("1218瀚海界王","点击场景副本暂时离开",StatManager.RUN_ACT_2015);
               this.begin();
               break;
            case "buyBtn":
               EventManager.addEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onCloseBuyPanel);
               ModuleManager.showModule(ClientConfig.getAppModule("MultiBuyPanel"),"",{
                  "productID":246160,
                  "iconID":1707536,
                  "exchangeID":7788
               });
               break;
            case "closeBtn":
               this.exit(null);
         }
      }
      
      private function onCloseBuyPanel(param1:RobotEvent) : void
      {
         EventManager.removeEventListener(RobotEvent.CLOSE_MUL_BUY_PANEL,this.onCloseBuyPanel);
         this.reset(true);
      }
      
      private function begin() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _loc2_ = this.conLevel["monster_" + _loc1_];
            this["_monster" + _loc1_] = new Monster({
               "mc":_loc2_,
               "start":this._monsters[_loc1_].start,
               "end":this._monsters[_loc1_].end,
               "dir":this._monsters[_loc1_].dir,
               "bossId":this._monsters[_loc1_].bossId
            });
            _loc1_++;
         }
         this.reset();
         MainManager.actorModel.visible = true;
         this.topLevel["panel"].visible = false;
      }
      
      private function reset(param1:Boolean = false) : void
      {
         var that:* = undefined;
         var begin:Boolean = param1;
         that = this;
         ItemManager.updateAndGetItemsNum([1707536],function(param1:Array):void
         {
            var i:int = 0;
            var arr:Array = param1;
            if(begin)
            {
               StatManager.sendStat2014("1218瀚海界王","打开寻找泽水明珠面板",StatManager.RUN_ACT_2015);
               KTool.showScore(that.topLevel["panel"]["valueMc"],arr[0]);
               that.topLevel["panel"].visible = true;
               MainManager.actorModel.visible = false;
            }
            else if(arr[0] >= 20)
            {
               KTool.doExchange(7787,function():void
               {
                  staticClazz.setObjectByKey("fightOver","pass");
                  Alarm.show("恭喜你通过泽水黄金盔！",function():void
                  {
                     exit(null);
                  });
               });
            }
            else
            {
               MainManager.actorModel.speed = defaultSpeed;
               KTool.showScore(that.conLevel["valueMc"],arr[0]);
               KTool.showScore(that.conLevel["tips"]["gotValueTxt"],_gotCount);
               that.conLevel.addEventListener(Event.ENTER_FRAME,onEnterFrame);
               i = 0;
               while(i < 5)
               {
                  if(i < _gotCount)
                  {
                     that.conLevel["item_" + i].visible = false;
                  }
                  else
                  {
                     that.conLevel["item_" + i].visible = true;
                  }
                  i++;
               }
            }
         });
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         var i:int;
         var e:Event = param1;
         if(this._gotCount > 0)
         {
            if(MainManager.actorModel.footMC.hitTestObject(this.conLevel["starting"]))
            {
               this.conLevel.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this.staticClazz.setObjectByKey("gotCount",0);
               if(!PetManager.isPackSpiriHavetHp && this.staticClazz.getObjectByKey("fightOver") != null)
               {
                  this._gotCount = 0;
                  this.reset();
               }
               else
               {
                  SocketConnection.sendWithCallback(47259,function(param1:SocketEvent):void
                  {
                     _gotCount = 0;
                     reset();
                  },3,this._gotCount);
               }
            }
         }
         i = 0;
         while(i < 5)
         {
            if(MainManager.actorModel.footMC.hitTestObject(this.conLevel["item_" + i]))
            {
               if(this.conLevel["item_" + i].visible)
               {
                  ++this._gotCount;
                  if(this._gotCount >= 5)
                  {
                     this._gotCount = 5;
                  }
                  KTool.showScore(this.conLevel["tips"]["gotValueTxt"],this._gotCount);
                  if(MainManager.actorModel.speed <= 1)
                  {
                     MainManager.actorModel.speed = 1;
                  }
                  else
                  {
                     MainManager.actorModel.speed -= 0.5;
                  }
                  this.staticClazz.setObjectByKey("gotCount",this._gotCount);
                  this.conLevel["item_" + i].visible = false;
               }
            }
            i++;
         }
      }
      
      private function onClickItem(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:Point = new Point(_loc2_.x,_loc2_.y);
         MainManager.actorModel.walkAction(_loc3_);
      }
      
      private function exit(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         StatManager.sendStat2014("1218瀚海界王","点击场景副本暂时离开",StatManager.RUN_ACT_2015);
         this.clearObject();
         MapManager.changeMapWithCallback(1147,function():void
         {
            ModuleManager.showAppModule("SeaKingStepsPanel");
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.speed = this.defaultSpeed;
         ToolBarController.panel.show();
         this.removeEvnets();
         this._monsters = null;
         this.defaultPoint = null;
         this.staticClazz = null;
         super.destroy();
      }
      
      private function clearObject() : void
      {
         this.staticClazz.setObjectByKey("gotCount",null);
         this.staticClazz.setObjectByKey("isFighting",null);
         this.staticClazz.setObjectByKey("fightOver",null);
         this.staticClazz.setObjectByKey("speed",null);
         this.staticClazz.setObjectByKey("actorPos",null);
      }
      
      private function removeEvnets() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this.conLevel["item_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onClickItem);
            _loc1_++;
         }
         this.topLevel["panel"].removeEventListener(MouseEvent.CLICK,this.onClickPanel);
         this.conLevel["exitBtn"].removeEventListener(MouseEvent.CLICK,this.exit);
         this.conLevel.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         if(this._monster0 != null && this._monster1 != null && this._monster2 != null)
         {
            this._monster0.destory();
            this._monster1.destory();
            this._monster2.destory();
         }
      }
   }
}

import com.robot.app.fight.FightManager;
import com.robot.core.manager.LevelManager;
import com.robot.core.manager.MainManager;
import com.robot.core.manager.MapManager;
import com.robot.core.manager.PetManager;
import com.robot.core.ui.alert.Alarm;
import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.utils.getDefinitionByName;
import flash.utils.setInterval;

class Monster
{
   
   private static const HOSTILITY_MAX:int = 20;
   
   private var monster:MovieClip;
   
   private var start:int;
   
   private var end:int;
   
   private var dir:int;
   
   private var bossId:int;
   
   private var _monsterSpeed:int = 3;
   
   private var count:int;
   
   private var staticClazz:*;
   
   private var _intervalId:int;
   
   private var _timerTicker:int;
   
   private var _collision:Boolean = false;
   
   public function Monster(param1:Object)
   {
      super();
      this.monster = param1.mc;
      this.start = param1.start;
      this.end = param1.end;
      this.dir = param1.dir;
      this.bossId = param1.bossId;
      this.staticClazz = getDefinitionByName("com.robot.app2.control.StaticObjectControll");
      this.count = 0;
      this._timerTicker = 0;
      LevelManager.topLevel.mouseChildren = LevelManager.topLevel.mouseEnabled = false;
      this.monster["dizziness"].visible = false;
      if(this.staticClazz.getObjectByKey("fightOver") != this.bossId + "")
      {
         LevelManager.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      else
      {
         this.monster["dizziness"].visible = true;
         this._intervalId = setInterval(this.timerHandler,1000);
      }
   }
   
   private function timerHandler() : void
   {
      ++this._timerTicker;
      if(this._timerTicker >= 10 && this.monster != null)
      {
         this._timerTicker = 0;
         this.monster["dizziness"].visible = false;
         LevelManager.stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
   }
   
   private function onEnterFrame(param1:Event) : void
   {
      if(this.monster == null)
      {
         return;
      }
      this.move();
      this.check();
   }
   
   private function move() : void
   {
      if(this._collision)
      {
         return;
      }
      if(this.monster.x >= this.start || this.monster.x <= this.end)
      {
         this.monster.scaleX *= -1;
      }
      this.monster.x += this.monster.scaleX * this._monsterSpeed * this.dir;
   }
   
   private function check() : void
   {
      this._collision = MainManager.actorModel.footMC.hitTestObject(this.monster["site"]);
      if(this._collision)
      {
         ++this.count;
         if(this.count >= HOSTILITY_MAX)
         {
            if(!this.staticClazz.getObjectByKey("isFighting"))
            {
               LevelManager.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this.count = 0;
               this.staticClazz.setObjectByKey("isFighting",true);
               Alarm.show("你太粗心了，被守护者发现了！",function():void
               {
                  fight();
               });
               return;
            }
         }
      }
      else
      {
         this.count = 0;
      }
   }
   
   private function fight() : void
   {
      if(this.staticClazz.getObjectByKey("fightOver") == "pass")
      {
         return;
      }
      if(MapManager.currentMap.id != 11026)
      {
         return;
      }
      this.staticClazz.setObjectByKey("fightOver",this.bossId + "");
      if(PetManager.isPackSpiriHavetHp)
      {
         FightManager.fightNoMapBoss("",this.bossId);
      }
      else
      {
         Alarm.show("背包精灵血量不足哦！先为他们补充吧！",function():void
         {
            MainManager.actorModel.pos = new Point(510,550);
            LevelManager.stage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            staticClazz.setObjectByKey("isFighting",false);
         });
      }
   }
   
   public function destory() : void
   {
      this.monster = null;
      this.staticClazz = null;
      LevelManager.topLevel.mouseChildren = LevelManager.topLevel.mouseEnabled = true;
      LevelManager.stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
   }
}
