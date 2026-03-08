package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alert;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10829 extends BaseMapProcess
   {
      
      public static const ALL_PETS:Array = [821,2562,2518,2608,2507,2427,1865,1122,2207,2233,2626,1949,1999,1836,1373,2459,1745,2463,2647,2667];
      
      protected var seerCircle:MovieClip;
      
      protected var buttonMC:MovieClip;
      
      public var PET_IDS:Array;
      
      protected var alarmMC:MovieClip;
      
      protected var fun1:Function;
      
      protected var fun2:Function;
      
      public function MapProcess_10829()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         this.PET_IDS = getDefinitionByName("com.robot.app2.control.RosefinchEvoController").PET_IDS;
         i = 0;
         while(i < 20)
         {
            conLevel["movePoint_" + i].visible = false;
            conLevel["pet_" + i].visible = false;
            conLevel["pet_" + i].mouseChildren = false;
            conLevel["pet_" + i].buttonMode = true;
            conLevel["pet_" + i].addEventListener(MouseEvent.CLICK,this.onFight);
            i++;
         }
         KTool.getMultiValue([1698],function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc2_:int = int(param1[0]);
            i = 0;
            while(i < 20)
            {
               _loc3_ = int(PET_IDS[i]);
               if(KTool.getBit(param1[0],ALL_PETS.indexOf(_loc3_) + 1))
               {
                  DisplayUtil.removeForParent(typeLevel["block_" + i]);
               }
               else
               {
                  loadPet(i,conLevel["pet_" + i]);
               }
               ++i;
            }
            MapManager.currentMap.makeMapArray();
         });
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         depthLevel.mouseChildren = false;
         depthLevel.mouseEnabled = false;
         this.buttonMC = MapManager.currentMap.libManager.getMovieClip("buttonMC");
         this.buttonMC.addEventListener(MouseEvent.CLICK,this.onButton);
         LevelManager.appLevel.addChild(this.buttonMC);
         topLevel["blackBg"].blendMode = BlendMode.LAYER;
         topLevel["blackBg"].mouseChildren = false;
         topLevel["blackBg"].mouseEnabled = false;
         topLevel["blackBg"].alpha = 0.85;
         topLevel["blackBg"].cacheAsBitmap = false;
         this.seerCircle = MapManager.currentMap.libManager.getMovieClip("LightCircle");
         this.seerCircle.scaleX = 2;
         this.seerCircle.scaleY = 2;
         this.seerCircle.x = MainManager.actorModel.pos.x - this.seerCircle.width * 0.5;
         this.seerCircle.y = MainManager.actorModel.pos.y - this.seerCircle.height * 0.5;
         this.seerCircle.mouseChildren = this.seerCircle.mouseEnabled = false;
         topLevel.addChild(this.seerCircle);
         this.seerCircle.blendMode = BlendMode.ERASE;
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
      }
      
      protected function walkHandler(param1:RobotEvent) : void
      {
         if(Boolean(this.seerCircle) && Boolean(MainManager.actorModel.visible))
         {
            this.seerCircle.x = MainManager.actorModel.pos.x - this.seerCircle.width * 0.5;
            this.seerCircle.y = MainManager.actorModel.pos.y - this.seerCircle.height * 0.5;
         }
      }
      
      protected function onButton(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target)
         {
            case this.buttonMC["cureBtn"]:
               PetManager.cureAll();
               break;
            case this.buttonMC["passBtn"]:
               this.showAlarm(2,function():void
               {
                  KTool.buyProductByCallback(242691,1,function():void
                  {
                     KTool.doExchange(5062,function():void
                     {
                        MapManager.changeMap(1066);
                     });
                     alarmMC.parent.removeChild(alarmMC);
                  });
               },function():void
               {
                  alarmMC.parent.removeChild(alarmMC);
               });
               break;
            case this.buttonMC["exitBtn"]:
               Alert.show("确定要离开吗？",function():void
               {
                  MapManager.changeMap(1067);
               });
         }
      }
      
      protected function onFight(param1:MouseEvent) : void
      {
         var a:Array = null;
         var e:MouseEvent = param1;
         a = String(e.target.name).split("_");
         var i:int = int(a[1]);
         MainManager.actorModel.moveAndAction(new Point(conLevel["movePoint_" + i].x,conLevel["movePoint_" + i].y),function():void
         {
            var crtPet:int = int(PET_IDS[int(a[1])]);
            var region:int = 3328 + ALL_PETS.indexOf(crtPet);
            FightManager.fightNoMapBoss("",region);
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               var info:FightOverInfo;
               var e:PetFightEvent = param1;
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               info = e.dataObj as FightOverInfo;
               if(info.winnerID != MainManager.actorID)
               {
                  KTool.getMultiValue([11641],function(param1:Array):void
                  {
                     var a:Array = param1;
                     if(a[0] >= getDefinitionByName("com.robot.app2.control.RosefinchEvoController").RETRY_TIMES)
                     {
                        Alarm.show("购买复活的次数达到上限！",function():void
                        {
                           MapManager.changeMap(1067);
                        });
                     }
                     else
                     {
                        showAlarm(1,function():void
                        {
                           KTool.buyProductByCallback(242690,1,function():void
                           {
                              KTool.doExchange(5061);
                              alarmMC.parent.removeChild(alarmMC);
                           });
                        },function():void
                        {
                           MapManager.changeMap(1067);
                        },a[0]);
                     }
                  });
               }
            });
         });
      }
      
      protected function loadPet(param1:int, param2:MovieClip) : void
      {
         var index:int = param1;
         var con:MovieClip = param2;
         DisplayUtil.removeAllChild(con);
         ResourceManager.getResource(ClientConfig.getPetSwfPath(this.PET_IDS[index]),function(param1:DisplayObject):void
         {
            con.visible = true;
            var _loc2_:MovieClip = param1 as MovieClip;
            con.addChild(_loc2_);
         },"pet");
      }
      
      override public function destroy() : void
      {
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
         this.buttonMC.removeEventListener(MouseEvent.CLICK,this.onButton);
         if(this.alarmMC)
         {
            this.alarmMC.removeEventListener(MouseEvent.CLICK,this.onAlarm);
         }
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            conLevel["pet_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onFight);
            _loc1_++;
         }
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
         super.destroy();
      }
      
      protected function showAlarm(param1:int, param2:Function, param3:Function, param4:int = 0) : void
      {
         if(this.alarmMC == null)
         {
            this.alarmMC = MapManager.currentMap.libManager.getMovieClip("alarmMC");
            this.alarmMC.addEventListener(MouseEvent.CLICK,this.onAlarm);
         }
         this.alarmMC["mc"].gotoAndStop(param1);
         LevelManager.appLevel.addChild(this.alarmMC);
         this.fun1 = param2;
         this.fun2 = param3;
         if(param1 == 1)
         {
            this.alarmMC["mc"]["txt"].text = "您当前剩余复活次数：" + int(getDefinitionByName("com.robot.app2.control.RosefinchEvoController").RETRY_TIMES - param4);
         }
      }
      
      protected function onAlarm(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.alarmMC["yesBtn"]:
               this.fun1();
               break;
            case this.alarmMC["noBtn"]:
               this.fun2();
         }
      }
   }
}

