using Autofac.Core;
using Microsoft.AspNetCore.Mvc;
using Rest_NetApi.Api.Views;
using Rest_NetApi.Domain.DTOs;
using Rest_NetApi.Domain.Entities;
using Rest_NetApi.Domain.Interface.IService;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Rest_NetApi.Api.Controllers
{
    [Route("/user")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService _service;

        public UserController(IUserService userappService)
        {
            _service = userappService;
        }
       // GET: api/<UserController>
        [HttpGet()]
        public IActionResult GetAll()
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();
                var users = _service.FindAll().Select(ViewParser.Parse);
                return Ok(users);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        [HttpPost()]
        public void Add([FromBody] UserView user)
        {
            _service.Save(user.ToDto());
          
        }


        [HttpPut()]
        [Route("/user/update/credit")]
        public IActionResult Put(Guid id, double credit)
        {
            try
            {
                _service.UpdateCredit(id, credit);

                return Ok("Sucess");
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        [HttpPut()]
        public IActionResult Put([FromBody] UserView user)
        {
            try
            {
                _service.Update(user.ToDto());

                return Ok(user);
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        // GET: api/<UserController>

        [HttpGet("{id}")]
        public IActionResult GetById(Guid id)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();

                var result = _service.FindById(id);

                if (result == null) return NotFound();

                return Ok(ViewParser.Parse(result));
            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }

        // login: api/<UserController>

        [HttpGet()]
        [Route("/user/login")]
        public IActionResult login(string email, string password)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest();

                var result = _service.UserLogin(email, password);

                if (result == null) return NotFound();

                return Ok(ViewParser.Parse(result));

            }
            catch (Exception e)
            {
                //add logs
                return StatusCode(StatusCodes.Status500InternalServerError, e.Message);

            }

        }
    }
    }
