package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
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
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.utils.ArrayUtils;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_11292 extends BaseMapProcess
   {
      
      public static var petids:Array;
      
      public static var fightover:Boolean;
      
      public static var bossStateforever:int;
      
      public static var statechanged:Boolean;
      
      private static var settimeid:int;
      
      public static const ALL_PETS:Array = [2988,2739,2882,3105,2844,3174,3149,2924,2746,2959,3036,3082,3136,2787,2709,2219,2156,3155,3135,2928,2765,2243,2205,2264,2321,2285,1906,2171,2914,2699,2655,2340,3027,2927,2228,2377,2347,1947,1777,1771,2948,2253,1925,2017,2211,1853,2446,3119,591,624];
      
      protected var seerCircle:MovieClip;
      
      protected var buttonMC:MovieClip;
      
      public var PET_IDS:Array;
      
      public function MapProcess_11292()
      {
         super();
      }
      
      override protected function init() : void
      {
         var a:Array = null;
         var idx:int = 0;
         var bossState:int = 0;
         var i:int = 0;
         while(i < 20)
         {
            conLevel["movePoint_" + i].visible = false;
            conLevel["pet_" + i].visible = false;
            conLevel["pet_" + i].mouseChildren = false;
            conLevel["pet_" + i].buttonMode = true;
            conLevel["pet_" + i].addEventListener(MouseEvent.CLICK,this.onFight);
            i++;
         }
         if(fightover)
         {
            settimeid = setInterval(function():void
            {
               var _loc1_:* = undefined;
               if(statechanged)
               {
                  clearInterval(settimeid);
                  statechanged = false;
                  _loc1_ = 0;
                  while(_loc1_ < 20)
                  {
                     if(KTool.getBit(bossStateforever,_loc1_ + 1))
                     {
                        DisplayUtil.removeForParent(typeLevel["block_" + _loc1_]);
                        DisplayUtil.removeAllChild(conLevel["pet_" + _loc1_]);
                     }
                     else
                     {
                        loadPet(_loc1_,conLevel["pet_" + _loc1_]);
                     }
                     MapManager.currentMap.makeMapArray();
                     _loc1_++;
                  }
               }
            },1000);
            fightover = false;
            this.PET_IDS = petids;
         }
         else
         {
            bossStateforever = 0;
            a = ALL_PETS.concat(ALL_PETS);
            idx = Math.round(Math.random() * 50);
            a = a.slice(idx,idx + 20);
            a = ArrayUtils.shuffle(a);
            this.PET_IDS = a;
            petids = a;
            bossState = bossStateforever;
            i = 0;
            while(i < 20)
            {
               if(KTool.getBit(bossState,i + 1))
               {
                  DisplayUtil.removeForParent(typeLevel["block_" + i]);
                  DisplayUtil.removeAllChild(conLevel["pet_" + i]);
               }
               else
               {
                  this.loadPet(i,conLevel["pet_" + i]);
               }
               i++;
            }
            MapManager.currentMap.makeMapArray();
         }
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         LevelManager.iconLevel.visible = false;
         depthLevel.mouseChildren = false;
         depthLevel.mouseEnabled = false;
         conLevel["door"].addEventListener(MouseEvent.CLICK,this.overHandle);
         this.buttonMC = MapManager.currentMap.libManager.getMovieClip("buttonMC");
         this.buttonMC.addEventListener(MouseEvent.CLICK,this.onButton);
         LevelManager.appLevel.addChild(this.buttonMC);
         topLevel["blackBg"].blendMode = BlendMode.LAYER;
         topLevel["blackBg"].mouseChildren = false;
         topLevel["blackBg"].mouseEnabled = false;
         topLevel["blackBg"].alpha = 1;
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
            case this.buttonMC["exitBtn"]:
               Alert.show("确定要离开吗？",function():void
               {
                  MapManager.changeMap(1202);
                  ModuleManager.showAppModule("ArenaPanel");
               });
               break;
            case this.buttonMC["passBtn"]:
               PetBagControllerNew.showByBuffer();
         }
      }
      
      protected function onFight(param1:MouseEvent) : void
      {
         var a:Array = null;
         var i:int = 0;
         var e:MouseEvent = param1;
         a = String(e.currentTarget.name).split("_");
         i = int(a[1]);
         MainManager.actorModel.moveAndAction(new Point(conLevel["movePoint_" + i].x,conLevel["movePoint_" + i].y),function():void
         {
            var crtPet:int = int(PET_IDS[int(a[1])]);
            var region:int = 7569 + ALL_PETS.indexOf(crtPet);
            FightManager.fightNoMapBoss("",region);
            fightover = true;
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               var _loc3_:FightOverInfo = param1.dataObj as FightOverInfo;
               if(_loc3_.winnerID == MainManager.actorID)
               {
                  bossStateforever += Math.pow(2,i);
               }
               statechanged = true;
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
      
      protected function overHandle(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         SocketConnection.sendByQueue(45674,[4,0],function(param1:*):void
         {
            MapManager.changeMap(1202);
            ModuleManager.showAppModule("ArenaPanel");
         },function(param1:*):void
         {
            MapManager.changeMap(1202);
         });
      }
      
      override public function destroy() : void
      {
         conLevel["door"].removeEventListener(MouseEvent.CLICK,this.overHandle);
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.walkHandler);
         this.buttonMC.removeEventListener(MouseEvent.CLICK,this.onButton);
         var _loc1_:int = 0;
         while(_loc1_ < 20)
         {
            conLevel["pet_" + _loc1_].removeEventListener(MouseEvent.CLICK,this.onFight);
            _loc1_++;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 20)
         {
            DisplayUtil.removeAllChild(conLevel["pet_" + _loc2_]);
            _loc2_++;
         }
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
         super.destroy();
      }
   }
}

